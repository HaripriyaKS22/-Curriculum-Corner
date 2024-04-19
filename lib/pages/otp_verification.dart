
import 'package:curriculum_corner/main.dart';
import 'package:curriculum_corner/pages/Authprovider.dart';
import 'package:curriculum_corner/pages/login.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';



class otphome extends StatelessWidget {

   FirebaseDatabase database = FirebaseDatabase.instance;
  
  String phone,fname,lname,email;
 otphome({ required this.fname, required this.lname, required this.email, required this.phone});
  TextEditingController otp=TextEditingController();

  @override
  Widget build(BuildContext context) {
   


    Provider.of<AuthProvide>(context,listen: false).signphone(phone);
    return Scaffold(
      
      body: Center(
        child: Padding(
           padding: const EdgeInsets.only(

              left: 20,
              right: 20,
              
            ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              

               SizedBox(height: 16,),
        
              TextField( controller: otp,
              decoration: InputDecoration( contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),labelText:"Enter your otp",border: OutlineInputBorder( borderRadius: BorderRadius.circular(15.0)),)),
              SizedBox(height: 16,),
              // ElevatedButton(onPressed: () async{
                

              // }, child: Text("submit")),

               SizedBox(
                        width: 200, // Adjust the width as needed
                        child: ElevatedButton(
                          onPressed: () async{
                            await Provider.of<AuthProvide>(context,listen: false).otpverify(otp.text,fname,lname,phone,email);
           



                Navigator.push(context, MaterialPageRoute(builder: (context) =>curriculumCorner_main()));


                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFFA3213C)),
                          ),
                          child: Text("Sign up",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
              
            ]
          ),
        ),
      ),

    );
  }
}