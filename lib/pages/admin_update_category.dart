// import 'package:curriculum_corner/pages/home.dart';
import 'dart:io';

import 'package:curriculum_corner/pages/admin_view_category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class update_category extends StatefulWidget {
  var id;

  update_category({required this.id});

  @override
  State<update_category> createState() => _update_categoryState();
}

class _update_categoryState extends State<update_category> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();

  var selectedfile;
  var category;
  var description;
  var categoryimageurl = {};
  var idlist = [];

  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("category");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?, Object?>) {
          categoryData.forEach((key, value) async {
            idlist.add(key);

            if (value != null && value is Map<Object?, Object?>) {
              if (key == widget.id) {
                category = value['categoryname'];

                description = value['categorydes'];
              }
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              //
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA3213C),
                      Color(0xFF49243F)
                    ], // Adjust colors as needed
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft:
                        Radius.circular(20), // Adjust the radius as needed
                    bottomRight:
                        Radius.circular(20), // Adjust the radius as needed
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Category",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle
                                    .italic, // Change the fontStyle here
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "lib/assets/student.png",
                      width: 130,
                      height: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: category,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Category")),
                        controller: con1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: con2,
                          decoration: InputDecoration(
                              hintText: description,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("Description"))),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            categoryimageupload();
                          },
                          child: Text("uplaod")),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: () {
                            updatecategory();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Add",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void categoryimageupload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          selectedfile = File(result.files.single.path!);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("file selected succesfully"),
          backgroundColor: Color.fromARGB(173, 120, 249, 126),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error while selecting the file"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void updatecategory() async {
    try {
      var docpath = await getApplicationDocumentsDirectory();
      var path = "${docpath.absolute}.png";
      if (selectedfile != null) {
        await FirebaseStorage.instance
            .ref()
            .child("category-image/${con1.text}")
            .putFile(selectedfile);
      }

      if (con1.text.isNotEmpty && con2.text.isNotEmpty) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("category");

        await ref.update({
          "${widget.id.toString()}/categoryname": con1.text,
          "${widget.id.toString()}/categorydes": con2.text,
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => view_category()));
      } else {
        print("fill out the fields");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("file selected succesfully"),
        backgroundColor: Color.fromARGB(173, 120, 249, 126),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("file selected failed"),
        backgroundColor: Color.fromARGB(172, 247, 45, 45),
      ));
    }
  }
}
