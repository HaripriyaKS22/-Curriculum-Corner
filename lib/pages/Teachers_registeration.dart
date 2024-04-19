import 'dart:io';

import 'package:curriculum_corner/pages/Techers_otp_verification.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:curriculum_corner/pages/otp_verification.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class Teacher_register extends StatefulWidget {
  const Teacher_register({super.key});

  @override
  State<Teacher_register> createState() => _Teacher_registerState();
}

class _Teacher_registerState extends State<Teacher_register> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
    TextEditingController con3 = new TextEditingController();
  TextEditingController con4 = new TextEditingController();
    TextEditingController con5 = new TextEditingController();
  TextEditingController con6 = new TextEditingController();

    var selectedfile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
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
                      children: [GestureDetector(
                      onTap: () {
                        
                        Navigator.of(context).pop(); 
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    
],
                    ),
                    Row(
                      children: [
                         Text(
                      "Register ",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                      ],
                    )
                   
                   
                    

                    
                  ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text(" First Name")),
                        controller: con1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Last Name")),
                        controller: con2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Email")),
                        controller: con3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: con4,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("Phone"))),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: con5,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("School/college name"))),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: () {

                            Teacheridimageupload();
                            

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                 Color.fromARGB(115, 73, 36, 63)),
                          ),
                          child: Text("Upload Teachers id",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      
                      
                             
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: () {
                             addTeachersid();
                             var phonenumber='+91${con4.text}';
                              Navigator.push(context, MaterialPageRoute(builder:(context) => Teacher_otphome(fname:con1.text,lname:con2.text,email:con3.text,phone: phonenumber,institute:con5.text),),);

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Sign up",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                     
                    ],
                  ),
                
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void Teacheridimageupload() async {
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

  void addTeachersid() async{

    try{

      var docpath = await getApplicationDocumentsDirectory();
      var path ="${docpath.absolute}.png";
      if(selectedfile != null){
        await FirebaseStorage.instance.ref().child("Teachers-id-image/${con1.text}").putFile(selectedfile);
      }
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("file uploaded succesfully"),
          backgroundColor: Color.fromARGB(173, 120, 249, 126),
        ));
      }
      catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("file upload failed"),
          backgroundColor: Color.fromARGB(172, 247, 45, 45),
        ));
    }
}
}