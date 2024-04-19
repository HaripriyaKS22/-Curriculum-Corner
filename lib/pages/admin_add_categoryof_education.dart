// import 'package:curriculum_corner/pages/home.dart';
import 'dart:io';

import 'package:curriculum_corner/pages/admin_view_category.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class education_category extends StatefulWidget {
  const education_category({super.key});

  @override
  State<education_category> createState() => _education_categoryState();
}

class _education_categoryState extends State<education_category> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  
  var selectedfile;
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
        fontStyle: FontStyle.italic, // Change the fontStyle here
      ),
    ),
  ],
), SizedBox(width: 188,),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                         
        
                              PopupMenuItem<String>(
                              value: 'categories',
                              child: Row(
                                children: [
                                  Text('categories'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            view_category()));
                                print('Button pressed');
                              },
                            ),
        
                          ],
                          onSelected: (String value) {
                            // Handle menu item selection here
                            print('You selected: $value');
                          },
                          icon: Icon(Icons.more_vert,color: Color.fromARGB(255, 255, 255, 255)),
                           
                        ),

                      ],
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 90.0),
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
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("Description"))),
                      SizedBox(
                        height: 20,
                      ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       categoryimageupload();
                      //     },
                      //     child: Text("uplaod")),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: ()  {
                            addcategory();
                           
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Add",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
  
  void addcategory() async{

    try{

   
      if(selectedfile != null){
        await FirebaseStorage.instance.ref().child("category-image/${con1.text}").putFile(selectedfile);
      }



     if (con1.text.isNotEmpty && con2.text.isNotEmpty) {
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("category");
                              DatabaseReference newuser = ref.push();

                              await newuser.set({
                                "categoryname": con1.text,
                                "categorydes": con2.text,
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          education_category()));
                            } else {
                              print("fill out the fields");
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("file selected succesfully"),
          backgroundColor: Color.fromARGB(173, 120, 249, 126),
        ));
    }
    catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("file selected failed"),
          backgroundColor: Color.fromARGB(172, 247, 45, 45),
        ));
    }
  }
}
