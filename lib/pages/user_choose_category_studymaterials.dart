// import 'package:curriculum_corner/pages/home.dart';
import 'dart:io';

import 'package:curriculum_corner/pages/admin_view_category.dart';
import 'package:curriculum_corner/pages/user_search_question_paper.dart';
import 'package:curriculum_corner/pages/user_search_studymaterials.dart';
import 'package:curriculum_corner/pages/user_view_questionpaper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class user_choose_category extends StatefulWidget {
  const user_choose_category({super.key});

  @override
  State<user_choose_category> createState() => _user_choose_categoryState();
}

class _user_choose_categoryState extends State<user_choose_category> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
 
  String selectedcat='';
  
var selectedfile;

List<String> categorylist = []; 
var selectedLocation;

  void initState() {
    super.initState();
   
    fetchcategory();

  }

   void fetchcategory()
  {
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("category");
      
    yeardataref.onValue.listen((DatabaseEvent event) {
      categorylist.clear();
      var data = event.snapshot.value;
      setState(() {
        if(data != null && data is Map<Object?,Object?>){
          data.forEach((key, value) async{
            if(value !=null && value is Map<Object?,Object?>){
              var cat = value["categoryname"];
              categorylist.add(cat.toString());
              selectedcat=cat.toString();
              print(categorylist);
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
                      Container(
  width: 320, 
  decoration: BoxDecoration(
    border: Border.all(color: Colors.grey), 
    borderRadius: BorderRadius.circular(10), 
  ),
  child: InputDecorator(
    decoration: InputDecoration(
      border: InputBorder.none,
      hintText: 'Select category', 
      labelText: 'Category', 
      contentPadding: EdgeInsets.symmetric(horizontal: 10), 
    ),
    child: DropdownButton<String>(
      value: selectedcat,
       underline: Container(),
      onChanged: (String? newValue) {
        setState(() {
          selectedcat = newValue!;
          print(selectedcat);
        });
      },
      items: categorylist.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    ),
  ),
),
 
SizedBox(height: 20,),

                      

                     


                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: ()  {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>user_searh_studymaterial(cat:selectedcat)));
                           
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
