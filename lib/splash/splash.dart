import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:side_app/main_screens.dart';
import '../main.dart';
import '../constants.dart';
class SplashScreen extends StatelessWidget {
  static String routeName = "/splash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 5,
                child: Center(
                  child: Text(
                    "i / N",
                    style: GoogleFonts.pacifico(fontSize: 28, color: Colors.white),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: TextButton(
                    child: Text("Continue"),
                    onPressed: () {
                      // 1
                      _completeSplash(context, MyApp());
                    },
                  ),
                ),
              ),
            ],
          )),
    );
  }

  void _completeSplash(BuildContext context, Widget widget) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (BuildContext context) => widget));
  }
}
