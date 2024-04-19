// import 'package:curriculum_corner/pages/home.dart';
import 'dart:io';

import 'package:curriculum_corner/pages/teachers_view_questionpaper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class teacher_previous_questionpaper extends StatefulWidget {
  const teacher_previous_questionpaper({super.key});

  @override
  State<teacher_previous_questionpaper> createState() => _teacher_previous_questionpaperState();
}

class _teacher_previous_questionpaperState extends State<teacher_previous_questionpaper> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  String selectedValue = '';
  String selectedyear= '';
  
var selectedfile;
List<String> educationlist = [];
List<String> yearlist = []; 
var selectedLocation;
FirebaseAuth auth = FirebaseAuth.instance;

  void initState() {
    super.initState();
    // Fetch locations from Firebase
    fetchEducation();
    fetchyear();

  }
  void fetchyear()
  {
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("year");
                    


      
    yeardataref.onValue.listen((DatabaseEvent event) {
      yearlist.clear();
      var data = event.snapshot.value;
      setState(() {
        if(data != null && data is Map<Object?,Object?>){
          data.forEach((key, value) async{
            if(value !=null && value is Map<Object?,Object?>){
              var year = value["Year"];
              yearlist.add(year.toString());
               selectedyear=year.toString();
              print(yearlist);
            }
           });
        }
      });
      
      
      
    });

  }

  void fetchEducation() {
     DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("education");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      educationlist.clear();
      
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
                 if (value != null && value is Map<Object?,Object?>) {
                  var datav = value['education'];
                  educationlist.add(datav.toString());
                  selectedValue=datav.toString();
                  
                  
                
                print("${educationlist}");
              
                
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


                          SizedBox(width: 260,),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                         
        
                              PopupMenuItem<String>(
                              value: 'Questions',
                              child: Row(
                                children: [
                                  Text('Questions'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            teacher_view_questionpaper()));
                                print('Button pressed');
                              },
                            ),
        
                          ],
                          onSelected: (String value) {
                            // Handle menu item selection here
                            print('You selected: $value');
                          },
                          icon: Icon(Icons.more_vert,color: Color.fromARGB(255, 255, 255, 255)),
                           
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              // Padding(
              //   padding: const EdgeInsets.only(top: 100.0),
              //   child: Container(
              //     child: ClipRRect(
              //       borderRadius: BorderRadius.circular(20.0),
              //       child: Image.asset(
              //         "lib/assets/student.png",
              //         width: 130,
              //         height: 130,
              //         fit: BoxFit.cover,
              //       ),
              //     ),
              //   ),
              // ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

Container(
  width: 320, 
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), 
    borderRadius: BorderRadius.circular(10), 
  ),
  child: InputDecorator(
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Select Education', 
      labelText: 'Education', 
      contentPadding: EdgeInsets.symmetric(horizontal: 10), 
    ),
    child: DropdownButton<String>(
      value: selectedValue,
      onChanged: (String? newValue) {
        setState(() {
          selectedValue = newValue!;
          print(selectedValue);
        });
      },
      items: educationlist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  ),
),


                      
                    
SizedBox(
                        height: 20,
                      ),
                       Container(
  width: 320, 
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), 
    borderRadius: BorderRadius.circular(10), 
  ),
  child: InputDecorator(
    decoration: InputDecoration(
      border: InputBorder.none, 
      hintText: 'Select Year', 
      labelText: 'Year', 
      contentPadding: EdgeInsets.symmetric(horizontal: 10), // Add padding
    ),
    child: DropdownButton<String>(
      value: selectedyear,
      onChanged: (String? newValue) {
        setState(() {
          selectedyear = newValue!;
          print(selectedyear);
        });
      },
      items: yearlist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  ),
),



SizedBox( height: 20,),

                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Question paper name")),
                        controller: con1,
                      ),


                      SizedBox(
                        height: 20,
                      ),
                     
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            Questionpeperimageupload();
                          },
                          child: Text("uplaod")),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: ()  async{
                            addQuestionpeperr();
                            //print("haaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa");
                            
                           
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

  void  Questionpeperimageupload() async {
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
  
  void addQuestionpeperr() async{

    try{
      User? user = auth.currentUser;
      String uid = user!.uid;
  
      if(selectedfile != null){
        await FirebaseStorage.instance.ref().child("Question-image/${con1.text}").putFile(selectedfile);
      }



     if (con1.text.isNotEmpty) {
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("Questions");
                              DatabaseReference newuser = ref.push();

                              await newuser.set({
                                "uid":uid,
                                "Year": selectedyear,
                                "Education": selectedValue,
                               "name" :con1.text
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          teacher_previous_questionpaper()));
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
