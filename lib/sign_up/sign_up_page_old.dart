import 'package:flutter/material.dart';
import 'package:sandbox/app_colors.dart';
import 'package:sandbox/components/progress_bar.dart';
import 'package:sandbox/components/slide_right_page_transitions_builder.dart';
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

  final navKey = GlobalKey<NavigatorState>();
  final Pet pet = Pet();
  final int questionCount = 5;
  int questionIndex = 0;

  Future<bool> onBackPress() async {
    print("onBackPress");
    if (!navKey.currentState.canPop()) {
      return true;
    }
    navKey.currentState.pop();
    setState(() {
      questionIndex--;
    });
    //updateRouteName();
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
                max: questionCount,
                index: questionIndex,
              ),
              body: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navKey,
                theme: ThemeData(
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.iOS: SlideRightPageTransitionsBuilder(),
                    TargetPlatform.android: SlideRightPageTransitionsBuilder(),
                  }),
                ),
                home: SignUpWelcome(),
                onGenerateRoute: (RouteSettings settings) {
                  final String routeName = settings.name;
                  setState(() {
                    questionIndex++;
                  });

                  return MaterialPageRoute(
                    settings: settings,
                    builder: routes[routeName],
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  final routes = {
    "/welcome": (context) => SignUpWelcome(),
    "/animal": (context) => IndexQuestionPage(
          question: "What type of pet do you have?",
          answers: ["dog", "cat"],
          icons: [Icons.android, Icons.accessible],
          index: 1,
          onAnswer: (String answer) {
            SignUpPageState.of(context).pet.animal = answer;
            Navigator.of(context).pushNamed("/sex");
          },
        ),
    "/sex": (context) => IndexQuestionPage(
          index: 2,
          question: "Is your ${SignUpPageState.of(context).pet.animal} a male or female?",
          answers: ["male", "female"],
          onAnswer: (String answer) {
            SignUpPageState.of(context).pet.sex = answer;
            Navigator.of(context).pushNamed("/age");
          },
        ),
    "/age": (context) => AgeQuestionPage(
          index: 3,
          question: "How old is ${SignUpPageState.of(context).pet.sex == 'male' ? "he" : "she"}?",
          onAnswer: (int months) {
            SignUpPageState.of(context).pet.months = months;
            print("Pet: ${SignUpPageState.of(context).pet.toJson()}");
            Navigator.of(context).pushNamed("/weight");
          },
        ),
    "/weight": (context) => IndexQuestionPage(
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
            Navigator.of(context).pushNamed("/final");
          },
        ),
    "/final": (context) => FinalPage(),
    "/json": (context) => JsonPage(json: SignUpPageState.of(context).pet.toJson())
  };
}
