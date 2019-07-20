import 'package:flutter/material.dart';
import 'package:snacker/app_colors.dart';
import 'package:snacker/sign_up_gender.dart';
import 'package:snacker/sign_up_welcome.dart';

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

  Future<bool> onBackPress() async {
    print("onBackPress");
    if (!navKey.currentState.canPop()) {
      return true;
    }
    navKey.currentState.pop();
    //updateRouteName();
    return false;
  }

  @override
  Widget build(BuildContext context) {
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
                  padding: EdgeInsets.symmetric(vertical: 32),
                  child: Text(
                    'Petcy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              body: MaterialApp(
                debugShowCheckedModeBanner: false,
                navigatorKey: navKey,
                theme: ThemeData(
                  backgroundColor: Color(0xFFF3F3F3),
                  pageTransitionsTheme: PageTransitionsTheme(builders: {
                    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
                    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                  }),
                ),
                home: SignUpWelcome(),
                onGenerateRoute: (RouteSettings settings) {
                  final String routeName = settings.name;
                  final Widget nextWidget = routes[routeName];
                  setState(() {});

                  return MaterialPageRoute(
                    settings: settings,
                    builder: (BuildContext context) => nextWidget,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  final routes = <String, Widget>{
    "/welcome": SignUpWelcome(),
    "/gender": SignUpGender(),
  };
}
