import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class user_view_studymaterial extends StatefulWidget {
  final String year;
  final String education;

  user_view_studymaterial({required this.year, required this.education});

  @override
  State<user_view_studymaterial> createState() =>
      _user_view_studymaterialState();
}

class _user_view_studymaterialState extends State<user_view_studymaterial> {
  List StudymaterialList = [];
  var educationdic = {};
  var yeardic = {};
  var questionimage = {};
  var Materialpdf = {};

  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("study_materials");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      StudymaterialList.clear();

      final Questionsref = event.snapshot.value;
      print("::::::::::::::::::::${Questionsref}");

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
          Questionsref.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              if (value['Year'] == widget.year &&
                  value['Education'] == widget.education) {
                print(
                    "yesssssssssssssssssssssssssssssssssssssssssssR${value['name']}");
                var datav = value['name'];
                StudymaterialList.add(datav);
                var educationn = value['Education'];
                var yearr = value['Year'];
                print(StudymaterialList);

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("Study-materials-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    questionimage[datav] = tempurl;
                    educationdic[datav] = educationn;
                    yeardic[datav] = yearr;
                  });
                } catch (e) {
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
 
  body: Container(
    padding: EdgeInsets.all(8.0),
    child: Column(
      children: [
        Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 193, 185, 185).withOpacity(0.5), // Color of the shadow
          spreadRadius: 5, // Spread radius
          blurRadius: 7, // Blur radius
          offset: Offset(0, 4), // Offset position of the shadow
        ),
            ],
               color: Colors.white,
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
                      SizedBox(height: 20,),
                       GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      

                     ClipRRect(
  borderRadius: BorderRadius.circular(20.0),
  child: Image.asset(
    "lib/assets/logo2.png",
    width: 100, // Change width to desired size
    height: 100, // Change height to desired size
    fit: BoxFit.contain, // Use BoxFit.contain to maintain aspect ratio
  ),
),

                   SizedBox(width: 190,),
                      
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
               
                height: 1,
                width: 60,
                color: Color.fromARGB(255, 215, 201, 201),
              
              ),
              SizedBox(width: 4),
              Text("Choose Your Won Way",style: TextStyle(
               color: Color.fromARGB(255, 215, 201, 201),
                
              ),),
               SizedBox(width: 4),
              Container(
               
                height: 1,
                width: 60,
                color: Color.fromARGB(255, 215, 201, 201),
              
              ),


              ],
            ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            itemCount: StudymaterialList.length,
            itemBuilder: (context, index) {
              return MyCard(
                title: StudymaterialList[index].toString(),
                education: educationdic[StudymaterialList[index].toString()]
                    .toString(),
                year: yeardic[StudymaterialList[index].toString()].toString(),
                photo: questionimage[StudymaterialList[index].toString()] ?? '',
              );
            },
          ),
        ),
      ],
    ),
  ),
);

  }
}

class MyCard extends StatelessWidget {
  final String title;
  final String photo;
  final String education;
  final String year;

  MyCard({
    required this.title,
    required this.photo,
    required this.year,
    required this.education,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          // Handle tap
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
             Image.asset(
                      "lib/assets/pdf.png",
                      width: 100,
                      height: 100,
                      //fit: BoxFit.cover,
                    ),
              Text(
                " $title",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
           
            ],
          ),
        ),
      ),
    );
  }
}
