import 'package:flutter/material.dart';

class JsonPage extends StatelessWidget {
  final Map<String, dynamic> json;

  const JsonPage({Key key, this.json}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: ListView(
          children: json
              .map((key, value) => MapEntry<String, Widget>(key, Text("$key: $value")))
              .values
              .toList(),
        ),
      ),
    );
  }
}
