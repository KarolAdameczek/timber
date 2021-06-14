import 'package:flutter/material.dart';

const textColor = Colors.white;
const shadowTextColor = Colors.white54;
const shadowColor = Colors.black26;
const btnColor = Color(0xFF7B5165);
const font = 'OpenSans';

final background = Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color(0xFFBFAAB2),
        Color(0xFFC292A4),
        Color(0xFFBF7792),
        Color(0xFFB8597D),
      ],
      stops: [0.1, 0.4, 0.7, 0.9],
    ),
  ),
);

final hintTextStyle = TextStyle(
  color: shadowTextColor,
  fontFamily: font,
);

final textShadow = Shadow(
  blurRadius: 3.5,
  color: shadowColor,
  offset: Offset(2.0, 2.0),
);

final labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: font,
  shadows: [
    textShadow,
  ]
);

final btnStyle = TextStyle(
  color: Color(0xFFBF7792),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final cardNameStyle = TextStyle(
  color: Color(0xFF505050),
  letterSpacing: 1.5,
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final subTextCardStyle = TextStyle(
  color: Color(0xFFBF7792),
  fontSize: 14.0,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final boxDecorationStyle = BoxDecoration(
  color: btnColor,
  borderRadius: BorderRadius.circular(30.0),
  boxShadow: [
    BoxShadow(
      color: shadowColor,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);

