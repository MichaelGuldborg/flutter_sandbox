import 'package:flutter/material.dart';
import 'package:sandbox/app_colors.dart';
import 'package:sandbox/components/rounded_button.dart';
import 'package:sandbox/components/material_container.dart';
import 'package:sandbox/sign_up/sign_up_page.dart';

class FinalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        color: Colors.transparent,
        child: ListView(
          padding: EdgeInsets.symmetric(
            vertical: 26,
            horizontal: 32,
          ),
          children: <Widget>[
            Container(
              child: Image.asset("assets/images/happy_dog.png"),
              // transform: Matrix4.translationValues(0.0, 20.0, 0.0),
            ),
            MaterialContainer(
              child: Container(
                margin: EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 24,
                ),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Max's tailored food plan is now ready!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 24),
                    Text(
                      "We've taken all the information you gave us about Max, and  we've designed a plan tailored just for him. "
                      "It's super tasty and packed with everything that Max needs to live a healthy and happy life.",
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 40),
                    RoundedButton(
                      text: "Show me the plan",
                      onPressed: () {
                        SignUpPageState.of(context).onNextPressed();
                      },
                      inverted: true,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
