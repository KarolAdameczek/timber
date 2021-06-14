import 'package:flutter/material.dart';
import 'package:flutter_app/models/card_model.dart';
import 'package:flutter_app/utilities/constants.dart';
import 'package:flutter_app/utilities/globals.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var matches;


  Widget _buildMatchCard(ProfileCard match) {
    return Container(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
        child: Card(
          color: Colors.white.withOpacity(0.7),
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: InkWell(
            splashColor: Colors.purple.withAlpha(80),
            borderRadius: BorderRadius.circular(20.0),
            onTap: () {
              Clipboard.setData(ClipboardData(text: match.email));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Container(
                    height: 20,
                    alignment: Alignment.center,
                    child: Text(
                      'Skopiowano email do schowka.',
                      style: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  duration: const Duration(milliseconds: 1000),
                  width: MediaQuery.of(context).size.width * 0.8,
                  // Width of the SnackBar.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, // Inner padding for SnackBar content.
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );
            },
            child: SizedBox(
              height: 140,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(match.name, style: cardNameStyle),
                    Text("Email: ${match.email}", style: subTextCardStyle),
                    Text("Typ miłości: ${match.loveType}", style: subTextCardStyle),
                    Text("Dwie najważniejsze rzeczy w związku: ${match.dragDrop}", style: subTextCardStyle),
                    Text("Wasz wynik: ${match.matchScore}%", style: subTextCardStyle),

                  ],
                ),
              ),
            ),
          ),
        ));
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
                vertical: 60.0,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Twoje dopasowania:',
                    style: TextStyle(
                      color: textColor,
                      fontFamily: 'OpenSans',
                      fontSize: 34.0,
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
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    alignment: Alignment.bottomLeft,
                    child: Text(
                      'Posortowane od najlepszego do najgorszego',
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontFamily: 'OpenSans',
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 2.0,
                            color: Colors.black26,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width,
                      height: 10000000,
                      child: FutureBuilder<List<ProfileCard>>(
                        future: api.generateMatchesRequest(),
                        builder: (BuildContext context, AsyncSnapshot<List<ProfileCard>> snapshot) {
                          if (snapshot.hasData) {
                            matches = snapshot.data;
                            return ListView.builder(
                                itemCount: matches.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _buildMatchCard(matches[index]);
                                });
                          } else {
                            return Container(width: 0.0, height: 0.0);
                          }
                        },
                      ))
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
