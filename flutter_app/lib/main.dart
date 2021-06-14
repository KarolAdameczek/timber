import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home_screen.dart';
import 'package:flutter_app/screens/starting_screen.dart';
import 'package:flutter_app/screens/login_screen.dart';
import 'package:flutter_app/screens/quiz/quiz_screen.dart';
import 'package:flutter_app/screens/signup_screen.dart';

void main() async{
  //print(await api.loginRequest("aaa@aaa.aaa","Papaj2137"));
  //print(api.apiToken);
  //print(await api.registerRequest('', '', ''));
  //var tmp = await api.generateMatchesRequest();
  //var tmp = await api.getSurveyRequest();
  //print(tmp.toString());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Timber',
      initialRoute: '/',
      routes: {
        '/': (context) => StartingScreen(),
        '/signin': (context) => LoginScreen(),
        '/signup': (context) => SignUpScreen(),
        '/quiz': (context) => QuizScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
