import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imagepicker/models/image_model.dart';

import 'imageview.dart';

List<Imagemodel> imagesList = [];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 75,
          backgroundColor: Colors.white60,
          title: Text(
            "Gallery",
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: imagesList.length == 0
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () async {
                        await imagepicker();
                      },
                      child: Container(
                        decoration: new BoxDecoration(
                          color: Colors.black12,
                          shape: BoxShape.circle,
                        ),
                        height: 100,
                        width: 100,
                        child: const Icon(
                          Icons.add_a_photo,
                          size: 50,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 12.0),
                      child: Text(
                        "No photos",
                        style: TextStyle(
                            color: Colors.black54, fontWeight: FontWeight.w500),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        await imagepicker();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Click to pick image",
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(imagesList.length, (index) {
                    return InkWell(
                      onTap: () async {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => Imageview(
                                    imagemodel: Imagemodel(
                                        path: imagesList[index].path,
                                        name: imagesList[index].name))));
                      },
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              height: double.maxFinite,
                              width: double.infinity,
                              child: Image.file(
                                File(imagesList[index].path),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black38,
                                borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(8.0),
                                    bottomRight: Radius.circular(8.0)),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  imagesList[index].name.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  softWrap: true,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    );
                  }),
                ),
              ),
        floatingActionButton: imagesList.length == 0
            ? Container()
            : InkWell(
                onTap: () async {
                  await imagepicker();
                },
                child: Container(
                  decoration: new BoxDecoration(
                    color: Colors.black12,
                    shape: BoxShape.circle,
                  ),
                  height: 100,
                  width: 100,
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ));
  }

  Future<void> imagepicker() async {
    final ImagePicker _picker = ImagePicker();
    // final XFile?
    List<XFile>? image = await _picker.pickMultiImage();
    image?.forEach((v) {
      imagesList.add(Imagemodel(name: v.name, path: v.path));
    });

    setState(() {});
  }
}
