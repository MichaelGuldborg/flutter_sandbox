import 'package:flutter/material.dart';
import 'package:snacker/camera_page.dart';
import 'package:snacker/gallery_page.dart';
import 'package:snacker/sign_up_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: 'Montserrat' // Nunito Sans
          ),
      initialRoute: '/',
      routes: {
        '/': (context) => _widget(context),
        '/camera': (context) => CameraPage(),
        '/gallery': (context) => GalleryPage(),
        '/sign_up': (context) => SignUpPage(),
      },
    );
  }

  Widget _widget(BuildContext context) => Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RaisedButton(
              child: Text('/sign_up'),
              onPressed: () {
                Navigator.of(context).pushNamed('/sign_up');
              },
            ),
            RaisedButton(
              child: Text('/camera'),
              onPressed: () {
                Navigator.of(context).pushNamed('/camera');
              },
            ),
            RaisedButton(
              child: Text('/gallery'),
              onPressed: () {
                Navigator.of(context).pushNamed('/gallery');
              },
            ),
          ],
        ),
      );
}

// https://stackoverflow.com/questions/42257668/the-equivalent-of-wrap-content-and-match-parent-in-flutter
