import 'package:flutter/material.dart';
import 'package:sandbox/components/answer_list.dart';
import 'package:sandbox/components/material_container.dart';

class QuestionPage extends StatelessWidget {
  final int index;
  final String question;
  final Widget child;

  const QuestionPage({
    Key key,
    @required this.index,
    @required this.question,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 32,
      ),
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "QUESTION $index OF 10",
              style: TextStyle(
                color: Colors.white.withAlpha(160),
                fontSize: 16,
                letterSpacing: 2,
              ),
            ),
            SizedBox(height: 24),
            Text(
              question,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 40),
            Expanded(
              child: MaterialContainer(
                child: child,
              ),
            ),
            SizedBox(height: 26),
          ],
        ),
      ),
    );
  }
}
