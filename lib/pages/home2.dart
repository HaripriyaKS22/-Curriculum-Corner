import 'package:carousel_slider/carousel_slider.dart';

import 'package:curriculum_corner/pages/login.dart';
import 'package:curriculum_corner/pages/my_order.dart';
import 'package:curriculum_corner/pages/orders.dart';
import 'package:curriculum_corner/pages/user_add_books.dart';
import 'package:curriculum_corner/pages/user_choose_category.dart';
import 'package:curriculum_corner/pages/user_choose_category_studymaterials.dart';
import 'package:curriculum_corner/pages/user_recived_request.dart';
import 'package:curriculum_corner/pages/user_search.dart';
import 'package:curriculum_corner/pages/user_view_all_books.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class home2 extends StatefulWidget {
  const home2({super.key});

  @override
  State<home2> createState() => _home2State();
}

class _home2State extends State<home2> {
  List<String> education = [];
  var selectededu;

  @override
  void initState() {
    super.initState();

    fetchcategory();
  }

  void fetchcategory() {
    DatabaseReference yeardataref = FirebaseDatabase.instance.ref("education");

    yeardataref.onValue.listen((DatabaseEvent event) {
      education.clear();
      var data = event.snapshot.value;
      setState(() {
        if (data != null && data is Map<Object?, Object?>) {
          data.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              var cat = value["education"];
              education.add(cat.toString());
              selectededu = cat.toString();
              print(selectededu);
            }
          });
        }
      });
    });
  }

  final List<String> imagePaths = [
    "lib/assets/white.jpg",
    "lib/assets/red.jpg",
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body:SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 100,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 193, 185, 185)
                          .withOpacity(0.5), // Color of the shadow
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
                        SizedBox(
                          height: 20,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.asset(
                            "lib/assets/logo2.png",
                            width: 100, // Change width to desired size
                            height: 100, // Change height to desired size
                            fit: BoxFit
                                .contain, // Use BoxFit.contain to maintain aspect ratio
                          ),
                        ),
                        SizedBox(
                          width: 190,
                        ),
                        PopupMenuButton<String>(
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                            PopupMenuItem<String>(
                              value: 'Add Book',
                              child: Row(
                                children: [
                                  Text('Add Book'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            add_book()));
                                print('Button pressed');
                              },
                            ),
                             PopupMenuItem<String>(
                              value: 'Requests',
                              child: Row(
                                children: [
                                  Text('Requests'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            user_recived_request()));
                                print('Button pressed');
                              },
                            ),

                            PopupMenuItem<String>(
                              value: 'Orders',
                              child: Row(
                                children: [
                                  Text('Orders'),
                                ],
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (contex) =>
                                            my_order()));
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
                          icon: Icon(Icons.more_vert,
                              color: const Color.fromARGB(255, 0, 0, 0)),
                        )
                      ],
                    ),
                    
                  
                  ]),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 330,
                height: 45,
                decoration: BoxDecoration(
                  border: Border.all(color: Color.fromARGB(255, 172, 165, 165)),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Row(
                  children: [
                    SizedBox(width: 20),
                    Container(
                        width: 200,
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select your class',
                            contentPadding: EdgeInsets.symmetric(horizontal: 1),
                          ),
                          child: DropdownButton<String>(
                            value: selectededu,
                            underline: Container(), // This removes the underline
                            onChanged: (String? newValue) {
                              setState(() {
                                selectededu = newValue!;
                                print(selectededu);
                              });
                            },
                            items: education
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),

                          
                        )),
                    SizedBox(
                      width: 50,
                    ),
                    Container(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      user_search(education: selectededu)));
                        },
                        child: Image.asset(
                          "lib/assets/search .png",
                          width: 30,
                          height: 30,
                          fit: BoxFit.cover,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 1,
                    width: 60,
                    color: Color.fromARGB(255, 215, 201, 201),
                  ),
                  SizedBox(width: 4),
                  Text(
                    "Choose Your Own Way",
                    style: TextStyle(
                      color: Color.fromARGB(255, 215, 201, 201),
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    height: 1,
                    width: 60,
                    color: Color.fromARGB(255, 215, 201, 201),
                  ),
                ],
              ),
              SizedBox(height: 20,),
             Container(
          width: 400, // Set width
          height: 120, // Set height
          child: Card(
            child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => user_view_all_books(),
                ),
              );
            },
            child: Image.asset(
              "lib/assets/booknow2.png",
              width: 400, // Set the same width as the container
              height: 125, // Set the same height as the container
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 85,left: 150),
            child: Positioned(
              top: 10, // Adjust the top position as needed
              left: 10, // Adjust the left position as needed
              child: Text(
                "BOOKS",
                style: TextStyle(
                  color: Color.fromARGB(255, 215, 214, 214), // Set text color
                  fontSize: 15, // Set text size
                 
                ),
              ),
            ),
          ),
        ],
            ),
          ),
        ),
        SizedBox(height: 20,),
        
         Container(
          color: Color.fromARGB(255, 248, 248, 248),
          
                 child: Padding(
                   padding: const EdgeInsets.only(top:10,bottom: 10),
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
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>user_choose_category()));
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
                                 "lib/assets/study.png", // Replace with the path to your image
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
                   SizedBox(width: 17,),
                   
                   
                   
                     SizedBox(
                     width: 147, // Set the desired width
                     height: 150, // Set the desired height
                     child: Card(
                         elevation: 3,
                         child: GestureDetector(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=>user_choose_cat()));
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
                                 "lib/assets/pdf.png", // Replace with the path to your image
                                 width: 90, // Set the desired width
                                 height: 90, // Set the desired height
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
        
                
        
        
            ],
          ),
        ),
      ),
    );
  }
}
