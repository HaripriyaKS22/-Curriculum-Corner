import 'package:curriculum_corner/pages/admin_add_categoryof_education.dart';
import 'package:curriculum_corner/pages/admin_add_education.dart';
import 'package:curriculum_corner/pages/admin_add_previousquestionpaper.dart';
import 'package:curriculum_corner/pages/admin_add_year.dart';
import 'package:curriculum_corner/pages/admin_view_questionpaper.dart';
import 'package:curriculum_corner/pages/admin_view_teachers.dart';
import 'package:curriculum_corner/pages/login.dart';
import 'package:curriculum_corner/pages/splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class admin_home2 extends StatefulWidget {
  const admin_home2({super.key});

  @override
  State<admin_home2> createState() => _admin_home2State();
}

class _admin_home2State extends State<admin_home2> {
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
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
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //             builder: (context) => education_category()));
                      //   },
                      //   child: Icon(
                      //     Icons.arrow_back_ios_new,
                      //     color: Colors.white,
                      //   ),
                      // ),
                       ClipRRect(
  borderRadius: BorderRadius.circular(20.0),
  child: Image.asset(
    "lib/assets/logo3.png",
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
                            value: 'Add category',
                            child: Row(
                              children: [
                                Text('Add Category'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          education_category()));
                              print('Button pressed');
                            },
                          ),

                          PopupMenuItem<String>(
                            value: 'Add years',
                            child: Row(
                              children: [
                                Text('Add year'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          admin_add_year()));
                              print('Button pressed');
                            },
                          ),


                          PopupMenuItem<String>(
                            value: 'Teachers',
                            child: Row(
                              children: [
                                Text('Teacher'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          view_Teachers()));
                              print('Button pressed');
                            },
                          ),

                            PopupMenuItem<String>(
                            value: 'Add Education',
                            child: Row(
                              children: [
                                Text('Add Education'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          admin_add_education()));
                              print('Button pressed');
                            },
                          ),
                           PopupMenuItem<String>(
                            value: 'Question papers',
                            child: Row(
                              children: [
                                Text('Question papers'),
                              ],
                            ),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) =>
                                          admin_view_questionpaper()));
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
                        icon: Icon(Icons.more_vert,color: Colors.white),
                         
                      )
                    ],
                  ),
                ]),
              ),
            ),
            Container(

            ),
            Padding(
              padding: const EdgeInsets.only(top:25),
              child: Container(
               
                height: 1,
                width: 300,
                color: Color.fromARGB(255, 215, 201, 201),
              
              ),
            ),
           Padding(
             padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
             child: Container(
             
               decoration: BoxDecoration(
               boxShadow: [
      BoxShadow(
        color: const Color.fromARGB(255, 193, 185, 185).withOpacity(0.5), // Color of the shadow
        spreadRadius: 5, // Spread radius
        blurRadius: 7, // Blur radius
        offset: Offset(0, 3), // Offset position of the shadow
      ),
    ],
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color.fromARGB(255, 244, 244, 244),
                    Color.fromARGB(255, 253, 226, 246)
                  ], // Adjust colors as needed
                ),
                borderRadius: BorderRadius.circular(20)
              ),
              
  width: double.infinity,
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
              builder: (context) => admin_previous_questionpaper(),
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
            // Padding(
            //   padding: const EdgeInsets.only(top:25),
            //   child: Container(
               
            //     height: 1,
            //     width: 300,
            //     color: Color.fromARGB(255, 215, 201, 201),
              
            //   ),
            // ),

           Padding(
             padding: const EdgeInsets.only(top: 20),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
               width: 147, // Set the desired width
               height: 150, // Set the desired height
               child: Card(
                   elevation: 3,
                   child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>education_category()));
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
        Text("Category",style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
                 ),
               ),)
             ),
             SizedBox(width: 17,),
             
             
             
               SizedBox(
               width: 147, // Set the desired width
               height: 150, // Set the desired height
               child: Card(
                   elevation: 3,
                   child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_add_education()));
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
        Text("Education",style: TextStyle(fontWeight: FontWeight.bold),)
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
                SizedBox(
               width: 147, // Set the desired width
               height: 150, // Set the desired height
               child: Card(
                   elevation: 3,
                   child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>admin_add_year()));
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
            "lib/assets/learning4.png", // Replace with the path to your image
            width: 100, // Set the desired width
            height: 100, // Set the desired height
            fit: BoxFit.cover, // Adjust the fit as needed
                   ),
         ),
        SizedBox(height: 5),
        Text("Year",style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
                 ),
               ),)
             ),
             SizedBox(width: 17,),
             
             
             
               SizedBox(
               width: 147, // Set the desired width
               height: 150, // Set the desired height
               child: Card(
                   elevation: 3,
                   child: GestureDetector(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context)=>view_Teachers()));
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
            "lib/assets/teacher.png", // Replace with the path to your image
            width: 100, // Set the desired width
            height: 100, // Set the desired height
            fit: BoxFit.cover, // Adjust the fit as needed
                   ),
         ),
        SizedBox(height: 5),
        Text("Teachers",style: TextStyle(fontWeight: FontWeight.bold),)
      ],
    ),
                 ),
               ),)
             ),
              ],
             
             
              
             ),
           ),
           


          ],
        ),
      ),
    );
  }
}
