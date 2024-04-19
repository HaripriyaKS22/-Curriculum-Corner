// import 'package:curriculum_corner/pages/home.dart';
import 'dart:io';

import 'package:curriculum_corner/pages/admin_view_category.dart';
import 'package:curriculum_corner/pages/teacher_view_studymaterials.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class teacher_update_studymaterial extends StatefulWidget {
  var id;
   teacher_update_studymaterial({required this.id});

  @override
  State<teacher_update_studymaterial> createState() => _teacher_update_studymaterialState();
}

class _teacher_update_studymaterialState extends State<teacher_update_studymaterial> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  String selectedValue = '';
  String selectedyear= '';
  var material;
 
  
var selectedfile;
List<String> educationlist = [];
List<String> yearlist = []; 
var selectedLocation;

  void initState() {
    super.initState();
    fetchmaterials();
    // Fetch locations from Firebase
    fetchEducation();
    fetchyear();

  }

  void fetchmaterials()async{
  


     DatabaseReference DataRef =
        FirebaseDatabase.instance.ref("study_materials");

     await DataRef.onValue.listen((DatabaseEvent event) {
     
  
      final Data = event.snapshot.value;

      setState(() {
        if (Data != null && Data is Map<Object?,Object?>) {
              Data.forEach((key, value) async {
              
                
                 if (value != null && value is Map<Object?,Object?>) {
                  if(key==widget.id){
                     material = value['name'];
                     print("objecttttttttttttttttttttttttttttttttttttttttttt ${material}");
                 
               

                  }
                 

                  
                
                
                
                 } 
              });
        }
      });
    });



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
                      ],
                    ),
                  ]),
                ),
              ),
              
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100, left: 20, right: 20),
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
                          hintText: material,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Study material name")),
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
                          onPressed: ()  {
                            addstudymaterial();
                           
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Update",
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
  
  void addstudymaterial() async{

    try{

      var docpath = await getApplicationDocumentsDirectory();
      var path ="${docpath.absolute}.pdf";
      if(selectedfile != null){
        await FirebaseStorage.instance.ref().child("Question-image/${con1.text}").putFile(selectedfile);
      }



     if (con1.text.isNotEmpty) {
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("study_materials");
                              DatabaseReference newuser = ref.push();

                              await newuser.set({
                                "Year": selectedyear,
                                "Education": selectedValue,
                               "name" :con1.text
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          teacher_view_studymaterials()));
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
