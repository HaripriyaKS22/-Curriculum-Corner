import 'package:curriculum_corner/pages/admin_update_year.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';

class view_year extends StatefulWidget {
  const view_year({super.key});

  @override
  State<view_year> createState() => _view_yearState();
}

class _view_yearState extends State<view_year> {
   List yearList = [];
   List idList = [];

   @override
  void initState() 
  {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("year");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      yearList.clear();
      
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
                idList.add(key);
                 if (value != null && value is Map<Object?,Object?>) {
                  var datav = value['Year'];
                  yearList.add(datav);
                  
                  
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
      appBar: AppBar(title: Text("years"),),
      body: Container(
        child: ListView.builder(
        itemCount: yearList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCard(
              title: yearList[index].toString(),
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
  var categoryimageurl;
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

                              DatabaseReference ref =
                            FirebaseDatabase.instance.ref("year");
                        await ref.child(widget.id.toString()).remove();

                              
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=>view_year()));
                             
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(  Color(0xFF49243F)),
                            ),
                            child: Text("Delete", style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 10,),
                
                          ElevatedButton(
                            onPressed: () {
                              
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_update_year(id:widget.id)));
                             
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
