import 'package:diabeticretinopathy/pages/information_page.dart';
import 'package:flutter/material.dart';
import 'package:diabeticretinopathy/pages/home_page.dart';
import 'package:diabeticretinopathy/pages/predict_page.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

void main() {
  runApp(MyApp());
}
//instantiate the application with the material UI package
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
    );
  }
}
//intialise the class of the homepage
class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentIndex = 0;
  List tabs = [HomePage(), PredictImage(), InformationPage()];//tabs for the bottom navigation bar
//widget code to design the mutable bottom navigation bar
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt_outlined), label: "Predict"),
          BottomNavigationBarItem(icon: Icon(Icons.web_stories), label: "News"),
        ],
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}
