import 'dart:io';

import 'package:apipractice/export_all.dart';
import 'package:http/http.dart%20';
import 'package:get/get.dart' as abc;
// import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PostApiTwoScreen extends StatefulWidget {
  const PostApiTwoScreen({super.key});

  @override
  State<PostApiTwoScreen> createState() => _PostApiTwoScreenState();
}

class _PostApiTwoScreenState extends State<PostApiTwoScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future<void> getImage() async {
    final _pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (_pickedFile != null) {
      image = File(_pickedFile.path);
      setState(() {});
    } else {
      print('no image found');
    }
  }

  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();

    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = new http.MultipartRequest('POST', uri);
    request.fields['title'] = 'This is First Product';
    var multiPart = new MultipartFile('image', stream, length);

    request.files.add(multiPart);
    var response = await request.send();

    if (response.statusCode == 200) {
      print('image uploaded');
      setState(() {
        showSpinner = false;
      });
      abc.Get.snackbar('Image', 'your image uploaded',
          backgroundColor: Colors.white);
    } else {
      print('Uploading Failed');
      setState(() {
        showSpinner = false;
      });

      abc.Get.snackbar('Image!', 'Uploading Failed',
          backgroundColor: Colors.white);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        // backgroundColor: Colors.w,
        appBar: AppBar(
          title: Text('Upload media Api'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: image == null
                    ? Center(
                        child: GestureDetector(
                            onTap: () => getImage(), child: Text('Pick Image')),
                      )
                    : Center(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: FileImage(
                            File(image!.path).absolute,
                          ),
                        ),
                      ),
              ),
              SizedBox(
                height: 50,
              ),
              ButtonWidget1(
                text: 'Upload File',
                onTap: () {
                  if (image != null) {
                    uploadImage();
                  } else {
                    abc.Get.snackbar('Image', 'please select the image',
                        backgroundColor: Colors.white);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
