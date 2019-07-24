import 'package:flutter/material.dart';
import 'package:sandbox/app_colors.dart';
import 'package:sandbox/components/progress_bar.dart';
import 'package:sandbox/models/pet.dart';
import 'package:sandbox/sign_up/age_question_page.dart';
import 'package:sandbox/sign_up/sign_up_success.dart';
import 'package:sandbox/sign_up/index_question_page.dart';
import 'package:sandbox/sign_up/json_page.dart';
import 'package:sandbox/sign_up/sign_up_welcome.dart';

class _SignUpPageStateProvider extends InheritedWidget {
  final SignUpPageState state;

  _SignUpPageStateProvider({this.state, child}) : super(child: child);

  @override
  bool updateShouldNotify(_SignUpPageStateProvider old) => false;
}

class SignUpPage extends StatefulWidget {
  SignUpPageState createState() => SignUpPageState();
}

class SignUpPageState extends State<SignUpPage> {
  static SignUpPageState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_SignUpPageStateProvider)
            as _SignUpPageStateProvider)
        .state;
  }

  final pageController = PageController();
  final Pet pet = Pet();
  int viewIndex = 0;

  final duration = const Duration(milliseconds: 400);
  final curve = Curves.decelerate;

  Future<bool> onNextPressed() async {
    pageController.nextPage(duration: duration, curve: curve);
    setState(() {
      viewIndex = pageController.page.round() + 1;
    });
    return false;
  }

  Future<bool> onBackPress() async {
    pageController.previousPage(duration: duration, curve: curve);
    setState(() {
      viewIndex = pageController.page.round() - 1;
    });
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final title = Text(
      'Petcy',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 32,
        fontWeight: FontWeight.w500,
      ),
    );

    return _SignUpPageStateProvider(
      state: this,
      child: WillPopScope(
        onWillPop: onBackPress,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColors.primary, AppColors.accent],
            ),
          ),
          child: SafeArea(
            child: Scaffold(
              backgroundColor: Colors.transparent,
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                  child: AppBar(
                    backgroundColor: Colors.transparent,
                    title: title,
                    centerTitle: true,
                    actions: <Widget>[
                      IconButton(
                        icon: Icon(
                          Icons.clear,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              bottomNavigationBar: ProgressBar(
                max: 6,
                index: viewIndex,
              ),
              body: PageView(
                controller: pageController,
                physics: NeverScrollableScrollPhysics(),
                children: <Widget>[
                  Builder(
                    builder: (context) => SignUpWelcome(),
                  ),
                  Builder(
                    builder: (context) => IndexQuestionPage(
                      index: 1,
                      question: "What type of pet do you have?",
                      answers: ["dog", "cat"],
                      icons: [Icons.android, Icons.accessible],
                      onAnswer: (String answer) {
                        SignUpPageState.of(context).pet.animal = answer;
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => IndexQuestionPage(
                      index: 2,
                      question:
                          "Is your ${SignUpPageState.of(context).pet.animal} a male or female?",
                      answers: ["male", "female"],
                      onAnswer: (String answer) {
                        SignUpPageState.of(context).pet.sex = answer;
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => AgeQuestionPage(
                      index: 3,
                      question:
                          "How old is ${SignUpPageState.of(context).pet.sex == 'male' ? "he" : "she"}?",
                      onAnswer: (int months) {
                        SignUpPageState.of(context).pet.months = months;
                        print("Pet: ${SignUpPageState.of(context).pet.toJson()}");
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => IndexQuestionPage(
                      index: 4,
                      question:
                          "How would you describe ${SignUpPageState.of(context).pet.sex == 'male' ? "his" : "her"} body condition?",
                      answers: [
                        "Skinny McBony",
                        "A bit underweight",
                        "Just about ideal",
                        "Undercover chubber",
                        "Obesepotamus",
                      ],
                      onAnswer: (String answer) {
                        SignUpPageState.of(context).pet.weight = answer;
                        print("Pet: ${SignUpPageState.of(context).pet.toJson()}");
                        onNextPressed();
                      },
                    ),
                  ),
                  Builder(
                    builder: (context) => FinalPage(),
                  ),
                  Builder(
                    builder: (context) => JsonPage(
                      json: SignUpPageState.of(context).pet.toJson(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
