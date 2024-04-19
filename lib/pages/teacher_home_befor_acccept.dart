import 'package:curriculum_corner/pages/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class teacher_home_before extends StatefulWidget {
  const teacher_home_before({super.key});

  @override
  State<teacher_home_before> createState() => _teacher_home_beforeState();
}

class _teacher_home_beforeState extends State<teacher_home_before> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(" Wait until admin ACCEPT you",style: TextStyle(color: Colors.grey),),
          ElevatedButton(style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFA3213C)),
                        ),
            onPressed: (){
              
            FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (contex) => login()));
          }, child: Text("logout",style: TextStyle(color: Colors.white),))
        ]
      )
    );
  }
}