
import 'package:curriculum_corner/pages/login.dart';
import 'package:curriculum_corner/pages/teacher_add_questionpaper.dart';
import 'package:curriculum_corner/pages/teachers_add_study_materials.dart.dart';
import 'package:curriculum_corner/pages/teachers_view_questionpaper.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:carousel_slider/carousel_slider.dart';

class teacher_home2 extends StatefulWidget {
  const teacher_home2({super.key});

  @override
  State<teacher_home2> createState() => _teacher_home2State();
}

class _teacher_home2State extends State<teacher_home2> {
   final List<String> imagePaths = [
    "lib/assets/white.jpg",
    "lib/assets/red.jpg",
    
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
                 color: Color.fromARGB(255, 255, 255, 255),
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
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                         
        
                              PopupMenuItem<String>(
                              value: 'Study materials',
                              child: Row(
                                children: [
                                  Text('Study materials'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            teacher_add_studymaterial()));
                                print('Button pressed');
                              },
                            ),
        
                             PopupMenuItem<String>(
                              value: 'Question paper',
                              child: Row(
                                children: [
                                  Text('Question paper'),
                                ],
                              ),
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => teacher_view_questionpaper()));
                                print('Button pressed');
                              },
                            ),
                             PopupMenuItem<String>(
                              value: 'Logout',
                              child: Row(
                                children: [
                                  Text('Logout'),
                                ],
                              ),
                              onTap: () {
                                FirebaseAuth.instance.signOut();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) => login()));
                                print('Button pressed');
                              },
                            ),
        
                            
        
        
        
                          ],
                          onSelected: (String value) {
                            // Handle menu item selection here
                            print('You selected: $value');
                          },
                          icon: Icon(Icons.more_vert,color: const Color.fromARGB(255, 0, 0, 0)),
                           
                        )
                      ],
                    ),
                  ]),
                ),
              ),
        
              
        
        
             Padding(
        padding: const EdgeInsets.only(top: 20),
        child: 
           CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.9,
            ),
            items: imagePaths.map((imagePath) {
              return Builder(
                builder: (BuildContext context) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      imagePath,
                      width: 350,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        
        
             Padding(
               padding: const EdgeInsets.only(top: 20),
               child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                 width: 155, // Set the desired width
                 height: 150, // Set the desired height
                 child: Card(
                     elevation: 3,
                     child: GestureDetector(
            onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>teacher_add_studymaterial()));
            },
          child:Container(
            decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1)
          ],
        ),
            ),
            child: Column(
        children: [
           Padding(
             padding: const EdgeInsets.only(top:5),
             child: Image.asset(
              "lib/assets/learning.png", // Replace with the path to your image
              width: 100, // Set the desired width
              height: 100, // Set the desired height
              fit: BoxFit.cover, // Adjust the fit as needed
                     ),
           ),
          SizedBox(height: 5),
          Text("Materials",style: TextStyle(fontWeight: FontWeight.bold),)
        ],
            ),
                   ),
                 ),)
               ),
               SizedBox(width: 15,),
               
               
               
                 SizedBox(
                 width: 155, // Set the desired width
                 height: 150, // Set the desired height
                 child: Card(
                     elevation: 3,
                     child: GestureDetector(
            onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>teacher_view_questionpaper()));
            },
          child:Container(
            decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(255, 255, 255, 1),
                      Color.fromRGBO(255, 255, 255, 1)
          ],
        ),
            ),
            child: Column(
        children: [
           Padding(
             padding: const EdgeInsets.only(top:5),
             child: Image.asset(
              "lib/assets/learning3.png", // Replace with the path to your image
              width: 100, // Set the desired width
              height: 100, // Set the desired height
              fit: BoxFit.cover, // Adjust the fit as needed
                     ),
           ),
          SizedBox(height: 5),
          Text("Questions",style: TextStyle(fontWeight: FontWeight.bold),)
        ],
            ),
                   ),
                 ),)
               ),
                ],
               
               
                
               ),
             ),
        
              Padding(
               padding: const EdgeInsets.only(top: 20),
               child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Lead the way",style: TextStyle(color: Color.fromARGB(255, 215, 201, 201), fontSize: 15,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                ),)
                ],
               ),
             ),
        
        
        
        
        
        
              Padding(
                padding: const EdgeInsets.only(top:20),
                child: Container(
                 
                  height: 1,
                  width: 300,
                  color: Color.fromARGB(255, 215, 201, 201),
                
                ),
              ),
        
            
        
        
        
             Padding(
               padding: const EdgeInsets.only(top: 20,left: 15,right: 15),
               child: Container(
        
                 decoration: BoxDecoration(
        
                      boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 193, 185, 185).withOpacity(0.5), // Color of the shadow
          spreadRadius: 5, // Spread radius
          blurRadius: 7, // Blur radius
          offset: Offset(0, 4), // Offset position of the shadow
        ),
            ],
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 250, 248, 248),
                      Color.fromARGB(255, 250, 230, 245)
                    ], // Adjust colors as needed
                  ),
                  borderRadius: BorderRadius.circular(20)
                ),
                
          width: 320,
          height: 150,
          
          child:Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
        children: [
        Column(
          children: [
            SizedBox(height: 10),
            
            Text(
        "Let's Add",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
            ),
            Row(
        children: [
          ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                colors: [
                  Color(0xFFA3213C),
                  Color.fromARGB(255, 226, 143, 75),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ).createShader(bounds);
            },
            child: Text(
              "New",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text(
            "Question papers",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
            ),
            SizedBox(height: 10),
            SizedBox(
        width: 100, // Adjust the width as needed
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => teacher_previous_questionpaper(),
              ),
            );
          },
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(
              Color(0xFFA3213C),
            ),
          ),
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
        ),
            ),
          ],
        ),
        
        
        SizedBox(width: 70,),
         Image.asset(
            "lib/assets/icon1.png",
            width: 50,
            height: 50,
            fit: BoxFit.contain, // Maintain the aspect ratio and cover the entire area
          ),
            
            ],),
          )
         
            
            
           
        ),
        
        
             )
        
            ],
          ),
        ),
      ),
    );
  }
}
