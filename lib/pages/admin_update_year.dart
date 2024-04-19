// import 'package:curriculum_corner/pages/home.dart';

import 'package:curriculum_corner/pages/admin_view_year.dart';

import 'package:firebase_database/firebase_database.dart';

// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class admin_update_year extends StatefulWidget {
  var id;
   admin_update_year({ required this.id});

  @override
  State<admin_update_year> createState() => _admin_update_yearState();
}

class _admin_update_yearState extends State<admin_update_year> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
 var year;
  var idlist=[];

  @override
  void initState() 
  {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("year");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
     
  
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
                idlist.add(key);
                
                 if (value != null && value is Map<Object?,Object?>) {
                  if(key==widget.id){
                     year = value['Year'];
                 
                 

                  }
                 

                  
                
                
                
                 } 
              });
        }
      });
    });
  }

 
  
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
                     


SizedBox( height: 20,),

                      TextField(
                        decoration: InputDecoration(
                          hintText: year,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Year")),
                        controller: con1,
                      ),


                    
                     
                      SizedBox(
                        height: 20,
                      ),
                     
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: ()  {
                            addYear();
                           
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

 
  
  void addYear() async{
     if (con1.text.isNotEmpty) {
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("year");
                            

                              await ref.update({
                                "${widget.id.toString()}/Year": con1.text,
                                
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                         view_year()));
                            } 
  }
}
