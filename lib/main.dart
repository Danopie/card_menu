import 'package:card_menu_demo/card_menu.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: CardMenuDemo(),
    );
  }
}

class CardMenuDemo extends StatefulWidget {
  @override
  _CardMenuDemoState createState() => _CardMenuDemoState();
}

class _CardMenuDemoState extends State<CardMenuDemo> {
  @override
  Widget build(BuildContext context) {
    return CardMenu();
  }
}
