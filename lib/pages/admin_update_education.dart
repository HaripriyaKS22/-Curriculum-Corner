
import 'package:curriculum_corner/pages/admin_view_education.dart';

import 'package:firebase_database/firebase_database.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class admin_update_education extends StatefulWidget {
  var id;
 admin_update_education({required this.id});

  @override
  State<admin_update_education> createState() => _admin_update_educationState();
}

class _admin_update_educationState extends State<admin_update_education> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  var education;
 
  
  var selectedfile;
   String selectedcat='PG';
   List<String> categorylist = []; 
   List educationList = [];
   List idList = [];
   @override
   void initState() {
    super.initState();
  
    fetchcategory();
        DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("education");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      educationList.clear();
      
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
               

                 if (value != null && value is Map<Object?,Object?>) {
                   education = value['education'];
                  educationList.add(education);
                  
                print("key: $education");
              
                
                 } 
              });
        }
      });
    });

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
                     


SizedBox( height: 20,),

                      TextField(
                        decoration: InputDecoration(
                          hintText: education,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Education")),
                        controller: con1,
                      ),


                    
                     
                      SizedBox(
                        height: 20,
                      ),
                     
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: ()  {
                            addeducation();
                           
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

 
  
  void addeducation() async{
     if (con1.text.isNotEmpty) {
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("education");
                             

                              await ref.update({
                                "${widget.id.toString()}/category":selectedcat,
                                "${widget.id.toString()}/education": con1.text,

                                
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         view_education()));
                            } 
  }
}
