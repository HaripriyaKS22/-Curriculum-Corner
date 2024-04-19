import 'package:curriculum_corner/pages/Register.dart';
import 'package:curriculum_corner/pages/Teachers_registeration.dart';


import 'package:curriculum_corner/pages/login_otp.dart';

import 'package:curriculum_corner/pages/user_choose_category.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';





class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
    TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: 
  
      
        SingleChildScrollView(
          child: Container(
             decoration: BoxDecoration(
          
                  
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFFA3213C),
                      Color(0xFF49243F)
                    ], // Adjust colors as needed
                  ),
                  
                ),
             
             
              
              child: Padding(
                padding: const EdgeInsets.only(top: 150),
                child: Container(
                  
                  decoration: BoxDecoration(
                   
                   color: Colors.white,
                   borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)
                   ),
                  
                         
                ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 55,
                    left: 20,
                    right: 20
                    ),
                    child: Column(
                             
                      
                    
                      children: [
                        
                        Text("Sign in",style: TextStyle(fontSize: 25,color: Color(0xFFA3213C)),),
                        SizedBox(height: 20,),
                        TextField(
                          decoration:InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal:15),border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),label: Text("Name"))
                          ,controller: con1,
                        ),
                        SizedBox(height: 20,),
                        TextField(
                          controller: con2,
                          decoration:InputDecoration(contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal:15),border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),label: Text("Phone"))
                        ),
                         SizedBox(height: 20,),
                         SizedBox(
                            width: 200, // Adjust the width as needed
                            child: ElevatedButton(
                              onPressed: () {
                                var phonenumber='+91${con2.text}';
                                Navigator.push(context, MaterialPageRoute(builder:(context) => login_otphome(phone:phonenumber)));
                              },
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>( Color(0xFFA3213C)),
                              ),
                              child: Text("Sign in", style: TextStyle(color: Colors.white)),
                            ),
                          ),
                         
                          Padding(
                            padding: const EdgeInsets.only(top: 250),
                            child: Row(
                              children: [
                              
                                 SizedBox(
                              width: 150, 
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder:(context) => register()));
                               
                                },
                                style: ButtonStyle(
                               
                                ),
                                child: Text("Student Signup", style: TextStyle(color:  Color(0xFFA3213C))),
                              ),
                            ),
                            SizedBox(width: 15,),
                               
                                 SizedBox(
                              width: 150, // Adjust the width as needed
                              child: ElevatedButton(
                                onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder:(context) =>Teacher_register()));
                               
                                },
                                style: ButtonStyle(
                               
                                ),
                                child: Text("Teacher Signup", style: TextStyle(color:  Color(0xFFA3213C))),
                              ),
                            ),
                              ],
                            ),
                          ),
                          
                          //  SizedBox(
                          //   width: 200, 
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       Navigator.push(context, MaterialPageRoute(builder:(context) => register()));
                             
                          //     },
                          //     style: ButtonStyle(
                             
                          //     ),
                          //     child: Text("Student Sign up", style: TextStyle(color:  Color(0xFFA3213C))),
                          //   ),
                          // ),
                          // SizedBox(height: 10,),
                             
                          
                          //  SizedBox(
                          //   width: 200, // Adjust the width as needed
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //        Navigator.push(context, MaterialPageRoute(builder:(context) =>Teacher_register()));
                             
                          //     },
                          //     style: ButtonStyle(
                             
                          //     ),
                          //     child: Text("Teacher Sign up", style: TextStyle(color:  Color(0xFFA3213C))),
                          //   ),
                          // ),
                         
                      ],
                      
                              
                    ),
                  ),
                ),
              ),
            ),
        ),
       
      
    );
  }
}