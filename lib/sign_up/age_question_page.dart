import 'package:flutter/material.dart';
import 'package:snacker/app_colors.dart';
import 'package:snacker/components/rounded_button.dart';
import 'package:snacker/sign_up/question_page.dart';

class AgeQuestionPage extends StatelessWidget {
  final int index;
  final String question;
  final Function(int) onAnswer;

  const AgeQuestionPage({
    Key key,
    @required this.index,
    @required this.question,
    @required this.onAnswer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final numberKey = GlobalKey<ScrollPickerState>();
    final multiplierKey = GlobalKey<ScrollPickerState>();

    return QuestionPage(
      index: index,
      question: question,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ScrollPicker(
                    key: numberKey,
                    items: ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"],
                  ),
                  SizedBox(width: 20),
                  ScrollPicker(
                    key: multiplierKey,
                    items: ["Months", "Years"],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 40),
          RoundedButton(
            text: "Next",
            inverted: true,
            onPressed: () {
              int number = numberKey.currentState.index + 1;
              int multiplier = multiplierKey.currentState.index == 0 ? 1 : 12;
              onAnswer(number * multiplier);
            },
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}

class ScrollPicker extends StatefulWidget {
  final List<String> items;
  final double width;
  final double height;
  final double itemHeight;

  const ScrollPicker({
    Key key,
    this.items,
    this.width = 80,
    this.height = 150,
  })  : itemHeight = height / 3,
        super(key: key);

  ScrollPickerState createState() => ScrollPickerState();
}

class ScrollPickerState extends State<ScrollPicker> {
  ScrollController controller;

  @override
  void initState() {
    controller = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  get index {
    double scrollPixels = controller.position.pixels;
    return (scrollPixels / widget.itemHeight).round();
  }

  @override
  Widget build(BuildContext context) {
    widget.items.insert(0, "");
    widget.items.add("");

    return Container(
      width: widget.width,
      height: widget.height,
      child: Stack(
        children: <Widget>[
          ListView(
              padding: EdgeInsets.zero,
              controller: controller,
              children: widget.items
                  .map(
                    (item) => _scrollPickerBox(item),
                  )
                  .toList()),
          Container(
            margin: EdgeInsets.only(top: widget.itemHeight - 2),
            height: 2,
            color: AppColors.primary,
          ),
          Container(
            margin: EdgeInsets.only(top: widget.itemHeight * 2 - 2),
            height: 2,
            color: AppColors.primary,
          ),
        ],
      ),
    );
  }

  Widget _scrollPickerBox(text) => Container(
        height: widget.itemHeight,
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      );
}
