import 'package:flutter/material.dart';
import 'assets/constants.dart' as Constants;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}
//widget code for designing the homepage
class _HomePageState extends State<HomePage> {
  Widget titleSection = Container(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(
              Constants.HOMETITLE,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange[700],
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            )),
        Container(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            Constants.HEADER,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.deepOrange[700],
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          child: Text(
            Constants.QUESTION,
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Colors.deepOrange[700],
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              Constants.EXPLANATION,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.deepOrange[700],
                fontSize: 18,
              ),
            )),
      ],
    ),
  );
// set the default layout of the page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Center(child: Text("Home")),
      ),
      backgroundColor: Colors.deepOrange[100],
      body: ListView(
        children: <Widget>[
          titleSection,
        ],
      ),
    );
  }
}
