import 'package:curriculum_corner/pages/otp_verification.dart';
// import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
    TextEditingController con3 = new TextEditingController();
  TextEditingController con4 = new TextEditingController();
    TextEditingController con5 = new TextEditingController();
  TextEditingController con6 = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 180,
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
                      children: [GestureDetector(
                      onTap: () {
                        
                        Navigator.of(context).pop(); 
                      },
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    
],
                    ),
                    Row(
                      children: [
                         Text(
                      "Register ",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                      ],
                    )
                   
                  ]),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 45,
                    left: 10,
                    right: 10,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text(" First Name")),
                        controller: con1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Last Name")),
                        controller: con2,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Email")),
                        controller: con3,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: con4,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("Phone"))),
                      SizedBox(
                        height: 20,
                      ),
                      
                      
                             
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: () {
                             var phonenumber='+91${con4.text}';
                                                    Navigator.push(context, MaterialPageRoute(builder:(context) => otphome(fname:con1.text,lname:con2.text,email:con3.text,phone: phonenumber),),);

                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Sign up",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                     
                    ],
                  ),
                
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
