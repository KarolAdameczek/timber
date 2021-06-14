import 'package:flutter/material.dart';
import 'package:flutter_app/utilities/constants.dart';

class StartingScreen extends StatelessWidget {
  Widget _buildSignInBtn(context) {
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
        onPressed: () {
          Navigator.pushNamed(context, '/signin');
        },
        child: Text(
          'ZALOGUJ SIĘ',
          style: btnStyle,
        ),
      ),
    );
  }

  Widget _buildSignUpBtn(context) {
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
        onPressed: () {
          Navigator.pushNamed(context, '/signup');
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
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 100.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(10.0),
                    child: Image.asset("assets/images/timber_logo.png"),
                  ),
                  SizedBox(height: 140.0),
                  _buildSignInBtn(context),
                  _buildSignUpBtn(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
