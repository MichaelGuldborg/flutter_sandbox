import 'package:flutter/material.dart';
import 'package:sandbox/app_colors.dart';
import 'package:sandbox/components/material_container.dart';

class AnswerList extends StatelessWidget {
  final List<String> answers;
  final List<IconData> icons;
  final Function(int) callback;
  final double borderRadius = 10;

  const AnswerList({
    Key key,
    @required this.answers,
    this.icons,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Widget> viewList = List();
    for (int i = 0; i < answers.length; i++) {
      bool isFirst = i == 0;
      bool isLast = i == answers.length - 1;

      final answerBox = AnswerBox(
        answer: answers[i],
        icon: icons?.length == answers.length ? icons[i] : null,
        onTap: () => callback(i),
        isFirst: isFirst,
        isLast: isLast,
      );
      viewList.add(answerBox);
      if (!isLast) {
        viewList.add(
          Container(
            color: Colors.black12,
            height: 2,
          ),
        );
      }
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: viewList,
    );
  }
}

class AnswerBox extends StatelessWidget {
  final double borderRadius = 10;
  final String answer;
  final IconData icon;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onTap;

  const AnswerBox({
    Key key,
    @required this.answer,
    this.icon,
    this.isFirst = false,
    this.isLast = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.vertical(
          top: isFirst ? Radius.circular(borderRadius) : Radius.circular(0),
          bottom: isLast ? Radius.circular(borderRadius) : Radius.circular(0),
        ),
        splashColor: AppColors.primary.withAlpha(200),
        child: Center(
          child: icon == null
              ? Text(
                  answer.replaceRange(0, 1, answer[0].toUpperCase()),
                  style: TextStyle(fontSize: 16),
                )
              : Icon(
                  icon,
                  color: AppColors.primary,
                  size: 60,
                ),
        ),
      ),
    );
  }
}
