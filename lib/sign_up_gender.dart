import 'package:flutter/material.dart';
import 'package:snacker/sign_up_page.dart';

class SignUpGender extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "QUESTION 1 OF 10",
              style: TextStyle(
                color: Colors.white.withAlpha(160),
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "What type of pet do you have?",
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Material(
                      color: Colors.white,
                      elevation: 10,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Center(
                              child: Text(
                                "Male",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(color: Colors.black, height: 1,),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Female",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
