import 'package:flutter/material.dart';
import 'package:flutter_app/models/question_model.dart';
import 'package:flutter_app/utilities/constants.dart';
import 'package:flutter_app/utilities/globals.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  String name;
  String email;
  String password;
  String repeatPassword;
  List<Question> questions;

  String response;

  _buildAlertDialog(context, String title, String desc) {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(desc),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  Widget _buildNameTI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Imię',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (String value) {
              name = value;
            },
            keyboardType: TextInputType.name,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.account_circle_outlined,
                color: textColor,
              ),
              hintText: 'Wprowadź Imię',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildEmailTI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Email',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (String value) {
              email = value;
            },
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.email_outlined,
                color: textColor,
              ),
              hintText: 'Wprowadź Email',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10.0)
      ],
    );
  }

  Widget _buildPasswordTI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Hasło',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (String value) {
              password = value;
            },
            obscureText: true,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: textColor,
              ),
              hintText: 'Wprowadź Hasło',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildRepeatPasswordTI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Powtórz Hasło',
          style: labelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: boxDecorationStyle,
          height: 60.0,
          child: TextField(
            onChanged: (String value) {
              repeatPassword = value;
            },
            obscureText: true,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock_outline,
                color: textColor,
              ),
              hintText: 'Wprowadź Hasło ponownie',
              hintStyle: hintTextStyle,
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          elevation: 5.0,
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        onPressed: () async => {
          if (name == null ||
              email == null ||
              password == null ||
              repeatPassword == null)
            {
              _buildAlertDialog(context, 'Wystąpił błąd',
                  'Nie podano wszystkich wymaganych danych'),
            }
          else if (password != repeatPassword)
            {
              _buildAlertDialog(
                  context, 'Wystąpił błąd', 'Hasła nie są identyczne.'),
            }
          else if (!nameRegEx.hasMatch(name))
            {
              print(name),
              _buildAlertDialog(context, 'Wystąpił błąd',
                  'Podano niepoprawne imie. Imie musi się zaczynać od dużej litery i może się składać tylko z liter.'),
            }
          else if (!emailRegEx.hasMatch(email))
            {
              _buildAlertDialog(
                  context, 'Wystąpił błąd', 'Podano niepoprawny email.'),
            }
          else if (!passwordRegEx.hasMatch(password))
            {
              _buildAlertDialog(context, 'Wystąpił błąd',
                  'Hasło powinno się składać z co najmniej 8 znaków, dużej i małej litery oraz cyfry.'),
            }
          else
            {
              response = await api.registerRequest(name, email, password),
              if (response == 'success')
                {
                  response = await api.loginRequest(email, password),
                  if(response == 'success'){
                    questions = await api.getSurveyRequest(),
                    Navigator.pushNamed(context, '/quiz', arguments: questions),
                  } else {
                    _buildAlertDialog(context, 'Wystąpił nieznany błąd', 'Skontaktuj się z administratorem.'),
                  }
                }
              else if (response == 'taken')
                {
                  _buildAlertDialog(
                      context, 'Wystąpił błąd', 'Adres email przypisany do innego konta.'),
                }
              else
                {throw Exception('Unknown login error!')}
            }
        },
        child: Text(
          'STWÓRZ KONTO',
          style: btnStyle,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          background,
          Container(
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.only(
                left: 40.0,
                right: 40.0,
                top: 100.0,
                bottom: 30.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Zarejestruj się',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'OpenSans',
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          blurRadius: 1.0,
                          color: Colors.black26,
                          offset: Offset(3.0, 3.0),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.0),
                  _buildNameTI(),
                  _buildEmailTI(),
                  _buildPasswordTI(),
                  _buildRepeatPasswordTI(),
                  SizedBox(height: 10.0),
                  _buildSignUpBtn(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
