import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:sandbox/camera_page.dart';
import 'package:sandbox/gallery_page.dart';
import 'package:sandbox/sign_up/sign_up_page.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Montserrat', // Nunito Sans
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => _widget(context),
        '/sign_up': (context) => SignUpPage(),
        '/home': (context) => HomePage(),
        '/camera': (context) => CameraPage(),
        '/gallery': (context) => GalleryPage(),
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
              child: Text('/home'),
              onPressed: () {
                Navigator.of(context).pushNamed('/home');
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

class HomePage extends StatefulWidget {
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final List<Widget> views = [
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.cyan,
    ),
    FAQPage(),
  ];
  int viewIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: viewIndex,
        items: [
          BottomNavigationBarItem(
            title: _navButton(text: "home"),
            icon: Container(),
          ),
          BottomNavigationBarItem(
            title: _navButton(text: "chat"),
            icon: Container(),
          ),
          BottomNavigationBarItem(
            title: _navButton(text: "faq"),
            icon: Container(),
          ),
        ],
        onTap: (int index) {
          setState(() => viewIndex = index);
        },
      ),
      body: views[viewIndex],
    );
  }

  Widget _navButton({String text = "null", isActive = false}) => Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      );
}

class FAQPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: <Widget>[
          SizedBox(height: 40),
          Text(
            "Frequently asked questions",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 40),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => EntryItem(data[index]),
              itemCount: data.length,
            ),
          ),
        ],
      ),
    );
  }
}

class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

final List<Entry> data = <Entry>[
  Entry(
    'Hvad er goodle Ads?',
    <Entry>[
      Entry(
        "Lorem Ipsum er ganske enkelt fyldtekst fra print- og typografiindustrien. Lorem Ipsum har været standard fyldtekst siden 1500-tallet, hvor en ukendt trykker sammensatte en tilfældig spalte for at trykke en bog til sammenligning af forskellige skrifttyper. Lorem Ipsum har ikke alene overlevet fem århundreder, men har også vundet indpas i elektronisk typografi uden væsentlige ændringer. Sætningen blev gjordt kendt i 1960'erne med lanceringen af Letraset-ark, som indeholdt",
      ),
    ],
  ),
  Entry(
    'Chapter B',
    <Entry>[
      Entry('Section B0'),
      Entry('Section B1'),
    ],
  ),
  Entry(
    'Chapter C',
    <Entry>[
      Entry('Section C0'),
      Entry('Section C1'),
      Entry(
        'Section C2',
        <Entry>[
          Entry('Item C2.0'),
          Entry('Item C2.1'),
          Entry('Item C2.2'),
          Entry('Item C2.3'),
        ],
      ),
    ],
  ),
];

// Displays one Entry. If the entry has children then it's displayed
// with an ExpansionTile.
class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) {
      return ListTile(
        title: Container(
          padding: EdgeInsets.only(bottom: 20),
          child: Text(root.title),
        ),
      );
    }
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

/*




class FAQPage extends StatefulWidget {
  FAQPageState createState() => FAQPageState();
}

class FAQPageState extends State<FAQPage> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  int currentState;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    animation = Tween(begin: math.pi / 2, end: -math.pi / 2).animate(animationController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              "Frequently asked questions",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40),
            GestureDetector(
              onTap: () {
                if (currentState == 0) {
                  animationController.forward();
                  currentState = 1;
                } else {
                  animationController.reverse();
                  currentState = 0;
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(color: Colors.grey.shade300, width: 2),
                    bottom: BorderSide(color: Colors.grey.shade300, width: 2),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            "Hvad er google ads?",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 18,
                            ),
                          ),
                          Transform.rotate(
                            angle: animation.value,
                            child: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.blueAccent,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedSize(
                      vsync: this,
                      duration: Duration(milliseconds: 500),
                      curve: Curves.fastOutSlowIn,
                      child: Container(
                        constraints: currentState == 1
                            ? BoxConstraints(maxHeight: 0.0)
                            : BoxConstraints(maxHeight: double.infinity),
                        padding: EdgeInsets.symmetric(vertical: 20),
                        child: Text(
                          "Lorem Ipsum er ganske enkelt fyldtekst fra print-hvor en ukendt trykker sammensatte en tilfældig spalte for at trykke en bog til sammenligning af forskellige skrifttyper. Lorem Ipsum har ikke alene overlevet fem århundreder, men har også vundet indpas i elektronisk typografi uden væsentlige ændringer. Sætningen blev gjordt kendt i 1960'erne med lanceringen af Letraset-ark, som indeholdt afsnit med Lorem Ipsum, og senere med layoutprogrammer som Aldus PageMaker, som også indeholdt en udgave af Lorem Ipsum.",
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
    );
  }
}

 */
