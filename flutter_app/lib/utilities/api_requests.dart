import 'dart:convert';

import 'package:flutter_app/models/card_model.dart';
import 'package:flutter_app/models/question_model.dart';
import 'package:http/http.dart' as http;

const String apiUrl = "https://timber-api.herokuapp.com";

class ApiRequests {
  String apiToken;
  bool loggedIn;
  bool surveyCompleted;

  ApiRequests() {
    loggedIn = false;
  }

  void logout() {
    apiToken = null;
    loggedIn = false;
  }

  bool getStatus() {
    return loggedIn;
  }

  Future<String> loginRequest(email, password) async {
    var response = await http.post(
      Uri.parse(apiUrl + '/login'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "email": email,
        "password": password,
      }),
    );
    var json = jsonDecode(response.body);
    if (response.statusCode == 200) {
      apiToken = json['token'];
      var jwtDecoded = parseJwt(apiToken);
      surveyCompleted = jwtDecoded['survey'];

      loggedIn = true;
      return json['msg'];
    } else if (json['msg'] == 'incorrect') {
      loggedIn = false;
      return json['msg'];
    } else {
      throw Exception('Api login error!');
    }
  }

  Future<String> registerRequest(name, email, password) async {
    var response = await http.post(
      Uri.parse(apiUrl + '/register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, String>{
        "name": name,
        "email": email,
        "password": password,
      }),
    );
    var json = jsonDecode(response.body);
    return json['msg'];
  }

  Future<List<Question>> getSurveyRequest() async {
    if (loggedIn == false) {
      return null;
    }
    var response = await http.get(
      Uri.parse(apiUrl + '/survey'),
      headers: <String, String>{
        'Authorization': 'Bearer ' + apiToken,
        'Accept': 'application/json',
        'Content-Type': 'application/jso; charset=utf-8'
      },
    );
    Map<String, dynamic> json = jsonDecode(response.body) as Map<String,dynamic>;
    List<Question> list = [];
    int i = 0;
    json.forEach((key, value) {
      if (value['type'] == 0) {
        list.add(new Question(
            id: i,
            type: 'Single',
            question: value['text'],
            options: [
              'Całkowicie się zgadzam',
              'Trochę się zgadzam',
              'Nie mam zdania',
              'Trochę się niezgadzam',
              'Całkowicie się niezgadzam'
            ],
            code: value['id']));
      } else if (value['type'] == 1) {
        list.add(new Question(
            id: i,
            type: 'Single',
            question: value['text'],
            options: value['items'].map((s) => s as String).toList(),
            code: value['id']));
      } else if (value['type'] == 2) {
        list.add(new Question(
            id: i,
            type: 'Sortable',
            question: value['text'],
            options: value['items'],
            code: value['id']));
      }
      i++;
    });
    return list;
  }

  Future<String> sendSurveyAnswers(List<String> answers) async {
    if (loggedIn == true) {
      var map={};
      for(int i = 0; i < answers.length; i++) {
        if(answers[i].length > 3){
          map[i.toString()] = answers[i];
        } else {
          map[i.toString()] = int.parse(answers[i]);
        }
      }
      var response = await http.post(
        Uri.parse(apiUrl + '/survey'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + apiToken,
          'Content-Type': 'application/json',
        },
        body: jsonEncode(map),
      );
      var json = jsonDecode(response.body);
      if(response.statusCode == 200){
        surveyCompleted = true;
      }
      return json['msg'];
    } else {
      return null;
    }
  }

  Future<List<ProfileCard>> generateMatchesRequest() async {
    if (loggedIn == true) {
      var response = await http.get(
        Uri.parse(apiUrl + '/matches'),
        headers: <String, String>{
          'Authorization': 'Bearer ' + apiToken,
        },
      );
      Map<String, dynamic> json = jsonDecode(response.body) as Map<String,dynamic>;
      List<ProfileCard> list = [];
      int i = 0;
      json.forEach((key, value){
        list.add(new ProfileCard(
          id: i,
          name: value['name'],
          email: value['email'],
          gender: value['gender'],
          dragDrop: value['drag_and_drop'],
          loveType: value['love_type'],
          matchScore: value['score'],
        ));
        i++;
      });
      return list;
    } else {
      return null;
    }
  }


  Map<String, dynamic> parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('invalid token');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('invalid payload');
    }

    return payloadMap;
  }

  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');

    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!"');
    }

    return utf8.decode(base64Url.decode(output));
  }
}
