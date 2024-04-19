import 'package:curriculum_corner/pages/update_question_paper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class teacher_view_questionpaper extends StatefulWidget {
 
   teacher_view_questionpaper( );

  @override
  State<teacher_view_questionpaper> createState() => _teacher_view_questionpaperState();
}

class _teacher_view_questionpaperState extends State<teacher_view_questionpaper> {

  List questionpaperList = [];
  var educationdic={};
  var yeardic={};
  var questionimage={};
  var idList=[];
  FirebaseAuth auth = FirebaseAuth.instance;

    @override
  void initState() 
  {
    super.initState();
     User? user = auth.currentUser;
      String uid = user!.uid;
      



    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("Questions");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      questionpaperList.clear();
     
  
      final Questionsref = event.snapshot.value;
      
   

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?,Object?>) {
              Questionsref.forEach((key, value) async {
                idList.add(key);
                 if (value != null && value is Map<Object?,Object?> ) {
                  if(uid==value['uid']){


                    var datav = value['name'];
                  questionpaperList.add(datav);
                  var educationn = value['Education'];
                  var yearr= value['Year'];
                  print(questionpaperList);

                  try{
                  var Reference =FirebaseStorage.instance.ref().child("Question-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    questionimage[datav]=tempurl;
                    educationdic[datav] = educationn ;
                    yeardic[datav] = yearr;
                    

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
      appBar: AppBar(title: Text("Question Pepers",style: TextStyle( fontSize: 20,
        fontWeight: FontWeight.bold,
        fontStyle: FontStyle.italic,color: Color(0xFFA3213C), ),),),
      body: Container(
        child: ListView.builder(
        itemCount: questionpaperList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCard(
              title: questionpaperList[index].toString(),
              education:educationdic[questionpaperList[index].toString()].toString(),
              year: yeardic[questionpaperList[index].toString()].toString(),
              photo: questionimage[ questionpaperList[index].toString()].toString(),
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
            child: Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              child: Image.network(
                widget.photo.toString(),
                fit: BoxFit.contain,
              ),
            ),
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
                      fontSize: 16,
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
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>update_questionpaper(id:widget.id)));

                    }, child: Text("Update",style: TextStyle(color: Colors.white))),
                  SizedBox(width:10,) ,
                  ElevatedButton(onPressed: ()async{
                     DatabaseReference ref =FirebaseDatabase.instance.ref("Questions");
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
              SizedBox(width: 20,),
              GestureDetector(
                onTap: () {
                  _showLargerImage(context); // Call the method to show larger image
                },

              child:Column(
                children: [
                   Image.network(  widget.photo.toString(),width: 100.0,height: 100.0,),
             

                ],
              )
              )

             
             
              
            ],
          ),
        ),
      ),),
    );
  }
}
