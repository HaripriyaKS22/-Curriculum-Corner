import 'package:curriculum_corner/pages/teacher_update_study_materials.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class teacher_view_studymaterials extends StatefulWidget {
 
   teacher_view_studymaterials( );

  @override
  State<teacher_view_studymaterials> createState() => _teacher_view_studymaterialsState();
}

class _teacher_view_studymaterialsState extends State<teacher_view_studymaterials> {

  List StudymaterialList = [];
  var educationdic={};
  var yeardic={};
  var Materialpdf={};
  var idList=[];
  FirebaseAuth auth = FirebaseAuth.instance;

    @override
  void initState() 
  {
    super.initState();
     User? user = auth.currentUser;
      String uid = user!.uid;

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("study_materials");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      StudymaterialList.clear();
     
  
      final Questionsref = event.snapshot.value;
      
   

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?,Object?>) {
              Questionsref.forEach((key, value) async {
                idList.add(key);
                 if (value != null && value is Map<Object?,Object?> ) {
                  if(uid==value['uid']){

                  var datav = value['name'];
                  StudymaterialList.add(datav);
                  var educationn = value['Education'];
                  var yearr= value['Year'];

                 

                  try{
                  var Reference =FirebaseStorage.instance.ref().child("Study-materials-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    
                    educationdic[datav] = educationn ;

                    yeardic[datav] = yearr;
                    Materialpdf[datav]=tempurl;

                   

                  });
                }
                catch(e){
                  
                  print(e);
                  
                }



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
      appBar: AppBar(title: Text("Materials",style: TextStyle( fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,color: Color(0xFFA3213C), ),),),
      body: Container(
        child: ListView.builder(
        itemCount: StudymaterialList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCard(
              title: StudymaterialList[index].toString(),
              education:educationdic[StudymaterialList[index].toString()].toString(),
              year: yeardic[StudymaterialList[index].toString()].toString(),
              photo: Materialpdf[ StudymaterialList[index].toString()].toString(),
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
  final String photo;
  final String education;
  final String year;
    final String id;
 
  MyCard({required this.title, required this.photo, required this.year, required this.education,required this.id});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var categoryimageurl;

  void _showLargerImage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop(); // Dismiss the dialog on tap
            },
            
          ),
        );
},
);
}
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
         elevation: 3,
        child:Container(

    decoration: BoxDecoration(

      borderRadius: BorderRadius.circular(10),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color.fromARGB(255, 228, 228, 228),
                    Color.fromARGB(255, 253, 226, 246)
        ],
      ),
    ),
      
       
        
       
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [

            
              Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     Text(
                    widget.title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                   
                  ),
                
                             
                 Text(
                    widget.education,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                   
                  ),
                
                 
                  Text(
                    widget.year,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                   
                  
                ),

                Row(
                  children: [ElevatedButton(
                    style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF49243F)),
                ),
                onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>teacher_update_studymaterial(id:widget.id)));

                    }, child: Text("Update",style: TextStyle(color: Colors.white))),
                  SizedBox(width:10,) ,
                  ElevatedButton(onPressed: ()async{
                     DatabaseReference ref =FirebaseDatabase.instance.ref("study_materials");
                            await ref.child(widget.id.toString()).remove();
                  },
                  style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Color(0xFFA3213C)),
                ),
                  
                  child: Text("Delete",style: TextStyle(color: Colors.white)))
                  
                  ],
                )
                  ],
                ),

              ),
              SizedBox(width: 10,),
               Column(
                children: [
                  Container(
              
             
                    
                    child: Image.asset(
                      "lib/assets/pdf.png",
                      width: 100,
                      height: 100,
                      //fit: BoxFit.cover,
                    ),
                  
            ),
                ],
               )
             
              
            ],
          ),
        ),
      ),),
    );
  }


   
}
