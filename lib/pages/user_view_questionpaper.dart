import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class user_view_questionpaper extends StatefulWidget {
  var year;
  var education;
   user_view_questionpaper( {this.year,this.education});

  @override
  State<user_view_questionpaper> createState() => _user_view_questionpaperState();
}

class _user_view_questionpaperState extends State<user_view_questionpaper> {

  List questionpaperList = [];
  var educationdic={};
  var yeardic={};
  var questionimage={};

    @override
  void initState() 
  {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("Questions");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      questionpaperList.clear();
     
  
      final Questionsref = event.snapshot.value;
      print("::::::::::::::::::::${Questionsref}");
   

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?,Object?>) {
              Questionsref.forEach((key, value) async {
                 if (value != null && value is Map<Object?,Object?> ) {

                  if(value['Year']==widget.year && value['Education'] == widget.education){
                    print("yesssssssssssssssssssssssssssssssssssssssssssR${value['name']}");
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
                  
                

                 
                  
              

                 
                // print("key: $datav");
                
                  

                 
                
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
        itemCount: questionpaperList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyCard(
              title: questionpaperList[index].toString(),
              education:educationdic[questionpaperList[index].toString()].toString(),
              year: yeardic[questionpaperList[index].toString()].toString(),
              photo: questionimage[ questionpaperList[index].toString()].toString(),

              
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
 
  MyCard({required this.title, required this.photo, required this.year, required this.education});

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
              Image.network(  widget.photo.toString(),width: 50.0,height: 50.0,),
              Spacer(),
                
              // ElevatedButton(
              //               onPressed: () {
                              
              //               Navigator.push(context, MaterialPageRoute(builder: (context)=>view_category()));
                             
              //               },
              //               style: ButtonStyle(
              //                 backgroundColor: MaterialStateProperty.all<Color>(  Color(0xFF49243F)),
              //               ),
              //               child: Text("Delete", style: TextStyle(color: Colors.white)),
              //             ),
                          // SizedBox(width: 10,),
                
                          // ElevatedButton(
                          //   onPressed: () {
                              
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>view_category()));
                             
                          //   },
                          //   style: ButtonStyle(
                          //     backgroundColor: MaterialStateProperty.all<Color>( Color(0xFFA3213C)),
                          //   ),
                          //   child: Text("Update", style: TextStyle(color: Colors.white)),
                          // ),
                          SizedBox(height: 20,)
              
            ],
          ),
        ),
      ),
    );
  }
}
