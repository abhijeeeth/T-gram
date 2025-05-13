import 'package:flutter/material.dart';

class ImageView extends StatefulWidget {
  String Images;
  ImageView({super.key, required this.Images});
  @override
  _ImageViewState createState() => _ImageViewState(Images);
}

class _ImageViewState extends State<ImageView> {
  String Images;
  _ImageViewState(this.Images);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Document View"),

          //backgroundColor: Colors.blueGrey,
          elevation: 0,
          //automaticallyImplyLeading: false,
        ),
        body: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(15),
          child: InteractiveViewer(
            minScale: 0.1,
            maxScale: 10.0,
            child: Image.network(
              Images,
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
