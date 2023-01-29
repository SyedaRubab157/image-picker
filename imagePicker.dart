import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({Key? key}) : super(key: key);

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  File? selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    // ignore: prefer_typing_uninitialized_variables
    var image;
    if (type == "camera") {
      image = await ImagePicker().pickImage(
        source: ImageSource.camera,
      );
    } else {
      image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
        // won't have any error now
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Upload Image"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Padding(
                  padding: const EdgeInsets.all(1), // Border radius
                  child: ClipOval(
                      child: selectedImage != null
                          ? Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      )
                          : Image.network(
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                        fit: BoxFit.cover,
                        height: 100,
                        width: 100,
                      )),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  chooseImage("camera");
                },
                child: const Text(" Image from Camera"),
              ),
              ElevatedButton(
                onPressed: () {
                  chooseImage("Gallery");
                },
                child: const Text("Image From Gallery"),
              ),
            ],
          ),
        ));
  }
}
