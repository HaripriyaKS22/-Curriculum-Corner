import 'package:curriculum_corner/pages/admin_update_education.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class view_education extends StatefulWidget {
  const view_education({super.key});

  @override
  State<view_education> createState() => _view_educationState();
}

class _view_educationState extends State<view_education> {
   List educationList = [];
   List idList = [];

   @override
  void initState() 
  {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("education");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      educationList.clear();
      
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
                idList.add(key);
                 if (value != null && value is Map<Object?,Object?>) {
                  var datav = value['education'];
                  educationList.add(datav);
                  
                print("key: $datav");
              
                
                 } 
              });
        }
      });
    });
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Education"),),
      body: Container(
        child: ListView.builder(
        itemCount: educationList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCard(
              title: educationList[index].toString(),
              id:idList[index]
             
              
            ),
          );
        },
      ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final String title;
  final String id;
  
  MyCard({required this.title,required this.id});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Card(
        color: const Color.fromARGB(255, 252, 252, 252),
          shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(10), // Set your desired border radius
    side: BorderSide(
      color: Colors.grey, // Set your desired border color
      width: 1, // Set your desired border width
    ),
  ),
        
        elevation: 3,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                 
                ),
              ),
              Spacer(),
              
                
              ElevatedButton(
                            onPressed: () async{
        DatabaseReference ref =FirebaseDatabase.instance.ref("education");
                            await ref.child(widget.id.toString()).remove();

                              
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>view_education()));
                             
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(  Color(0xFF49243F)),
                            ),
                            child: Text("Delete", style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 10,),
                
                          ElevatedButton(
                            onPressed: () {
                              
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_update_education(id:widget.id)));
                             
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>( Color(0xFFA3213C)),
                            ),
                            child: Text("Update", style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(height: 20,)
              
            ],
          ),
        ),
      ),
    );
  }
}
