import 'package:flutter/material.dart';
import 'package:snacker/components/answer_list.dart';
import 'package:snacker/sign_up/question_page.dart';

class IndexQuestionPage extends StatelessWidget {
  final int index;
  final String question;
  final List<String> answers;
  final List<IconData> icons;
  final Function(String) onAnswer;

  const IndexQuestionPage({
    Key key,
    @required this.index,
    @required this.question,
    @required this.answers,
    this.icons,
    this.onAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QuestionPage(
      index: index,
      question: question,
      child: AnswerList(
        answers: answers,
        icons: icons,
        callback: (int index) => onAnswer(answers[index]),
      ),
    );
  }
}
