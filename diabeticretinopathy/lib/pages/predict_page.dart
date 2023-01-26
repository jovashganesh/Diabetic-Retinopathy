import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class PredictImage extends StatefulWidget {
  const PredictImage({Key? key}) : super(key: key);
//create new entity for the model creation
  @override
  State<PredictImage> createState() => _PredictImageState();
}
//variables required for model prediction
class _PredictImageState extends State<PredictImage> {
  bool _loading = true;
  late File _image;
  late List _output;
  final picker = ImagePicker();
//loading the model is run asynchronously
  @override
  void initState() {
    super.initState();
    loadModel().then((value) {
      setState(() {});
    });
  }
// free up system memory when the model has finished prediction
  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }
//method to classify the image
  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
      path: image.path,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    ); //normalise the image so the pixel values are even
    setState(() {
      _output = output!;
      _loading = false;
    });
  }
//load the model
  loadModel() async {
    await Tflite.loadModel(
        model: 'assets/model.tflite', labels: 'assets/labels.txt');
  }
// async function to wait for the user to select the camera for the model to be called
  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }
// async function to wait for the user to select the gallery for the model to be called
  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);
    if (image == null) return null;
    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }
//variable to set the the selected image by the user
  late Size size = MediaQuery.of(context).size;
//widget code to design the layout of the predict page
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange[600],
          icon: Icon(Icons.camera),
          label: Text('Upload Image'),
          onPressed: (pickGalleryImage),
        ),
        SizedBox(
          height: 10,
        ),
        FloatingActionButton.extended(
          backgroundColor: Colors.deepOrange[600],
          icon: Icon(Icons.camera_alt_outlined),
          label: Text('Take Image'),
          onPressed: (pickImage),
        ),
      ]),
      appBar: AppBar(
        backgroundColor: Colors.deepOrange[300],
        title: Center(child: Text("Predict Image")),
      ),
      backgroundColor: Colors.deepOrange[100],
      body: Stack(
        children: [
          Positioned(
            height: size.height * 0.7,
            width: size.width,
            child: Container(
              child: Center(
                child: _loading == true
                    ? Container(
                        child: Text(
                          "Upload or Take a Picture!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 26,
                            color: Colors.deepOrange[700],
                          ),
                        ),
                      ) //show nothing if no picture selected
                    : Container(
                        child: Column(
                          children: [
                            SizedBox(
                              height: 40,
                            ),
                            Container(
                              height: 300,
                              width: 300,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: Image.file(
                                  _image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            ),
          ),
          Positioned(
            top: size.height * 0.50,
            height: size.height * 0.50,
            width: size.width,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.deepOrange[300],
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(36.0),
                  topRight: Radius.circular(36.0),
                ),
              ),
              child: _loading == true
                  ? null
                  : Column(
                      children: [
                        SizedBox(
                          height: 21,
                        ),
                        Text(
                          "Prediction",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepOrange[700],
                          ),
                        ),
                        SizedBox(
                          height: 17,
                        ),
                        _output != null
                            ? Center(
                                child: Text(
                                  '${_output[0]['label']} diabetic retinopathy detected!',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                    color: Colors.deepOrange[700],
                                  ),
                                ),
                              )
                            : Container()
                      ],
                    ),
            ),
          )
        ],
      ),
    );
  }
}
