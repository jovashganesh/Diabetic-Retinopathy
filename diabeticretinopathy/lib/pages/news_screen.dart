import 'package:diabeticretinopathy/pages/api.dart';
import 'package:diabeticretinopathy/pages/newsmodel.dart';
import 'package:flutter/material.dart';

class HealthNews extends StatelessWidget {
  final NewsModel model; //retrive the data for the specific news article to be displayed
  const HealthNews({required this.model, Key? key}) : super(key: key);
//widget code to design the layout of the news page
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.deepOrange[100],
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
      ),
      body: Container(
        height: size.height,
        width: size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                width: size.width / 1.1,
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                height: size.height / 4,
                width: size.width / 1.1,
                alignment: Alignment.center,
                child: model.imageUrl != ""
                    ? Image.network(
                        model.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Text("Cant Load image"),
              ),
              Container(
                width: size.width / 1.1,
                child: Text(
                  model.content,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
