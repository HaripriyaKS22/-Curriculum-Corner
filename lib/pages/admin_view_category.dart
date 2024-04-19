import 'package:curriculum_corner/pages/admin_update_category.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class view_category extends StatefulWidget {
  const view_category({super.key});

  @override
  State<view_category> createState() => _view_categoryState();
}

class _view_categoryState extends State<view_category> {
   List categoryList = [];
  List descriptionlist = [];
  var categoryimageurl={};
  var idlist=[];

   @override
  void initState() 
  {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("category");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      categoryList.clear();
      descriptionlist.clear();
      categoryimageurl.clear();
  
      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?,Object?>) {
              categoryData.forEach((key, value) async {
                idlist.add(key);
                 if (value != null && value is Map<Object?,Object?>) {
                  var datav = value['categoryname'];
                  categoryList.add(datav);
                  var des = value['categorydes'];
                  descriptionlist.add(des);
                print("key: $datav");
                try{
                  var Reference =FirebaseStorage.instance.ref().child("category-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    categoryimageurl[datav]=tempurl;
                  });
                }
                catch(e){
                  
                  print("e");
                  
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
      appBar: AppBar(title: Text("Categories"),),
      body: Container(
        child: ListView.builder(
        itemCount: categoryList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCard(
              title: categoryList[index].toString(),
              photo: categoryimageurl[ categoryList[index].toString()].toString(),
              id:idlist[index],
              
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
  final String photo;
  final String id;
 
  MyCard({required this.title, required this.photo, required this.id});

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
              // Image.network(  widget.photo.toString(),width: 50.0,height: 50.0,),
              Spacer(),
                
              ElevatedButton(
                            onPressed: () async{
                               DatabaseReference ref =
                            FirebaseDatabase.instance.ref("category");
                            await ref.child(widget.id.toString()).remove();
                              
                             
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(  Color(0xFF49243F)),
                            ),
                            child: Text("Delete", style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(width: 10,),
                
                          ElevatedButton(
                            onPressed: () {
                              
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>update_category(id:widget.id)));
                             
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
