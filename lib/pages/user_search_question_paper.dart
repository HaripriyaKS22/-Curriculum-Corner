// import 'package:curriculum_corner/pages/home.dart';
import 'dart:io';

import 'package:curriculum_corner/pages/admin_view_category.dart';
import 'package:curriculum_corner/pages/user_view_questionpaper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class user_searh_questionpaper extends StatefulWidget {
  var cat;
  user_searh_questionpaper({required this.cat});

  @override
  State<user_searh_questionpaper> createState() => _user_searh_questionpaperState();
}

class _user_searh_questionpaperState extends State<user_searh_questionpaper> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  
  String selectedValue ='';
  String selectedyear='';
  
  
var selectedfile;
List<String> educationlist = [];
List<String> yearlist = []; 
List<String> categorylist = []; 
var selectedLocation;

  void initState() {
    super.initState();
    // Fetch locations from Firebase
    fetchEducation();
    fetchyear();
    // fetchcategory();

  }

   void fetchcategory()
  async{
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("category");
      
   await yeardataref.onValue.listen((DatabaseEvent event) {
      categorylist.clear();
      var data = event.snapshot.value;
      setState(() {
        if(data != null && data is Map<Object?,Object?>){
          data.forEach((key, value) async{
            if(value !=null && value is Map<Object?,Object?>){
              var cat = value["categoryname"];
              categorylist.add(cat.toString());
              print(categorylist);
            }
           });
        }
      });
      
      
      
    });

  }
  void fetchyear()
  async{
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("year");
      
    await yeardataref.onValue.listen((DatabaseEvent event) {
      yearlist.clear();
      var data = event.snapshot.value;
      setState(() {
        if(data != null && data is Map<Object?,Object?>){
          data.forEach((key, value) async{
            if(value !=null && value is Map<Object?,Object?>){
              var year = value["Year"];
              yearlist.add(year.toString());
              selectedyear = year.toString();
              print(yearlist);
            }
           });
        }
      });
      
      
      
    });

  }

  void fetchEducation() async{
     DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("education");

    await categoryDataRef.onValue.listen((DatabaseEvent event) {
      educationlist.clear();
      
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
                 if (value != null && value is Map<Object?,Object?>) {
                  // print("ffffffffffffffffffffffffffffffffffffffffffffff${value['category']}");
                  //  print("ffffffffffffffffffffffffffffffffffffffffffffff${widget.cat}");
                  if(widget.cat == value['category']){
                     var datav = value['education'];
                  educationlist.add(datav.toString());
                  selectedValue = datav.toString();

                   print("rrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr${educationlist}");
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
                      ],
                    ),
                  ]),
                ),
              ),
             
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                     
SizedBox(height: 20,),

                      

                     

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
      value:selectedValue ,
       underline: Container(),
      
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
       underline: Container(),
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

                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: ()  {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>user_view_questionpaper(year:selectedyear,education:selectedValue)));
                           
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Search",
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


 
}
