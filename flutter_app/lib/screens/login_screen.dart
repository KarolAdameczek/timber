import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/models/question_model.dart';
import 'package:flutter_app/utilities/constants.dart';
import 'package:flutter_app/utilities/globals.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email;
  String password;
  String response;
  List<Question> questions;

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
      ],
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => print('TODO: Forgot Password Btn Pressed!'),
        child: Text(
          'Nie pamiętasz hasła?',
          style: labelStyle,
        ),
      ),
    );
  }

  Widget _buildSignInBtn() {
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
          if (email == null || password == null)
            {
              _buildAlertDialog(context, 'Wystąpił błąd',
                  'Podano niepoprawny email lub hasło.'),
            }
          else
            {
              response = await api.loginRequest(email, password),
              if (response == 'success')
                {
                  if (!api.surveyCompleted)
                    {
                      questions = await api.getSurveyRequest(),
                      Navigator.pushNamed(context, '/quiz',
                          arguments: questions),
                    } else
                    {
                      Navigator.pushNamed(context, '/home'),
                    }
                }
              else if (response == 'incorrect')
                {
                  _buildAlertDialog(
                      context, 'Wystąpił błąd', 'Wprowadzono niepoprawne dane')
                }
              else
                {throw Exception('Unknown login error!')}
            }
        },
        child: Text(
          'ZALOGUJ',
          style: btnStyle,
        ),
      ),
    );
  }

  Widget _buildSignUpBtn() {
    return TextButton(
      onPressed: () => Navigator.pushNamed(context, '/signup'),
      child: Text(
        "Nie masz konta? Zarejestruj się",
        style: labelStyle,
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
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 100.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'Logowanie',
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
                  SizedBox(height: 40.0),
                  _buildEmailTI(),
                  _buildPasswordTI(),
                  _buildForgotPasswordBtn(),
                  _buildSignInBtn(),
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
