import 'package:diabeticretinopathy/pages/api.dart';
import 'package:diabeticretinopathy/pages/news_screen.dart';
import 'package:diabeticretinopathy/pages/newsmodel.dart';
import 'package:flutter/material.dart';

class InformationPage extends StatefulWidget {
  const InformationPage({Key? key}) : super(key: key);

  @override
  State<InformationPage> createState() => _InformationPageState();
}
//method to retrieve the news articles and display on the page
class _InformationPageState extends State<InformationPage> {
  List<NewsModel>? newList; //contains the articles by calling the class
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getNews().then((value) {
      setState(() {
        if (value.isNotEmpty) {
          newList = value;
          isLoading = false; //checks if any articles can be loaded
        } else {
          print("No news available");
        }
        ;
      });
    });
  }
//widget code to design the layout of the news page
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Center(child: Text("Health News")),
      ),
      backgroundColor: Colors.deepOrange[100],
      body: Column(
        children: [
          SizedBox(
            height: 15,
          ),
          isLoading
              ? Align(
                  child: Container(
                    height: size.height / 20,
                    width: size.height / 20,
                  ),
                )
              : Expanded(child: Container(
                  child: ListView.builder(itemBuilder: (context, index) {
                    return listItems(size, newList![index]);
                  }),
                ))
        ],
      ),
    );
  }

  Widget listItems(Size size, NewsModel model) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
      child: GestureDetector(
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => HealthNews(
              model: model,
            ),
          ),
        ),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          width: size.width / 1.15,
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white),
          ),
          child: Column(
            children: [
              Container(
                height: size.height / 4,
                width: size.width / 1.05,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(width: 1, color: Colors.white),
                  ),
                ),
                child: model.imageUrl != ""
                    ? Image.network(
                        model.imageUrl,
                        fit: BoxFit.cover,
                      )
                    : Text("Cant Load image"),
              ),
              Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Container(
                width: size.width / 1.1,
                padding: EdgeInsets.symmetric(vertical: 5),
                child: Text(
                  model.description,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
