import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool ohturn = true;
  List<String> displayEx0h = ['', '', '', '', '', '', '', '', ''];
  var myTextStyle = const TextStyle(color: Colors.white, fontSize: 30);
  var myTextStyle2 = const TextStyle(color: Colors.white, fontSize: 20);
  int exscore = 0;
  int ohscore = 0;
  int filled = 0;

  static var myNewFont = GoogleFonts.pressStart2p(
      textStyle: const TextStyle(color: Colors.black, letterSpacing: 3));
  static var myNewFontWhite = GoogleFonts.pressStart2p(
      textStyle:
          const TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 15));
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: Column(
        children: [
          const SizedBox(height: 15,),
          Expanded(
            child: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player X',
                          style: myNewFontWhite,
                        ),
                        const SizedBox(height: 20),
                        Text(exscore.toString(), style: myNewFontWhite),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Player O',
                          style: myNewFontWhite,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          ohscore.toString(),
                          style: myNewFontWhite,
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: GridView.builder(
                itemCount: 9,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: (Colors.grey[700])!)),
                      child: Center(
                        child: Text(
                          displayEx0h[index],
                          style: const TextStyle(
                              color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                }),
          ),
          Expanded(
            child: Container(
              child: Column(children: [
                const SizedBox(height: 10),
                Text('TIC TAC TOE', style: myNewFontWhite),
                const SizedBox(height: 15),
                Text('@ALPHAPANTHERKILO', style: myNewFontWhite),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohturn && displayEx0h[index] == '') {
        displayEx0h[index] = 'o';
        filled++;
      } else if (!ohturn && displayEx0h[index] == '') {
        displayEx0h[index] = 'x';
        filled++;
      }
      ohturn = !ohturn;

      Timer(const Duration(milliseconds: 500), () {
        _checkwinner();
      });
    });
  }

  void _checkwinner() {
    //row 1
    if (displayEx0h[0] == displayEx0h[1] &&
        displayEx0h[0] == displayEx0h[2] &&
        displayEx0h[0] != '') {
      _showwindialog(displayEx0h[0]);
    }
    //row 2
    if (displayEx0h[3] == displayEx0h[4] &&
        displayEx0h[3] == displayEx0h[5] &&
        displayEx0h[3] != '') {
      _showwindialog(displayEx0h[3]);
    }
    //row 3
    if (displayEx0h[6] == displayEx0h[7] &&
        displayEx0h[6] == displayEx0h[8] &&
        displayEx0h[6] != '') {
      _showwindialog(displayEx0h[6]);
    }
    //column 1
    if (displayEx0h[0] == displayEx0h[3] &&
        displayEx0h[0] == displayEx0h[6] &&
        displayEx0h[0] != '') {
      _showwindialog(displayEx0h[0]);
    }
    //column 2
    if (displayEx0h[1] == displayEx0h[4] &&
        displayEx0h[1] == displayEx0h[7] &&
        displayEx0h[1] != '') {
      _showwindialog(displayEx0h[1]);
    }
    //column 3
    if (displayEx0h[2] == displayEx0h[5] &&
        displayEx0h[2] == displayEx0h[8] &&
        displayEx0h[2] != '') {
      _showwindialog(displayEx0h[2]);
    }
    //diagonal 1
    if (displayEx0h[0] == displayEx0h[4] &&
        displayEx0h[0] == displayEx0h[8] &&
        displayEx0h[0] != '') {
      _showwindialog(displayEx0h[0]);
    }
    //diagonal 2
    if (displayEx0h[2] == displayEx0h[4] &&
        displayEx0h[2] == displayEx0h[6] &&
        displayEx0h[2] != '') {
      _showwindialog(displayEx0h[2]);
    } else if (filled == 9) {
      _showDrawdialog();
    }
  }

  void _showDrawdialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('DRAW', style: myNewFont,),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _clear();
                  Navigator.of(context).pop();
                },
                child: Text("PLAY AGAIN!", style: myNewFont),
              )
            ],
          );
        });
    _clear();
  }

  void _showwindialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('WINNER IS : $winner', style: myNewFont),
            actions: [
              ElevatedButton(
                onPressed: () {
                  _clear();
                  Navigator.of(context).pop();
                },
                child: Text("PLAY AGAIN!", style: myNewFont),
              )
            ],
          );
        });

    if (winner == 'o') {
      ohscore++;
    } else if (winner == 'x') {
      exscore++;
    }
    _clear();
  }

  void _clear() {
    setState(() {
      for (int i = 0; i < 9; i++) {
        displayEx0h[i] = '';
      }
    });
    filled = 0;
  }
}
