import 'package:curriculum_corner/pages/Register.dart';
import 'package:curriculum_corner/pages/admin_home.dart';
import 'package:curriculum_corner/pages/home.dart';
import 'package:curriculum_corner/pages/login.dart';
import 'package:curriculum_corner/pages/teacher_home.dart';
import 'package:curriculum_corner/pages/teacher_home_befor_acccept.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:curriculum_corner/pages/Authprovider.dart';
import 'package:firebase_database/firebase_database.dart';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ChangeNotifierProvider(
      create: (context) => AuthProvide(), child: CurriculumCorner()));
}

class CurriculumCorner extends StatefulWidget {
  const CurriculumCorner({super.key});

  @override
  State<CurriculumCorner> createState() => _CurriculumCornerState();
}

class _CurriculumCornerState extends State<CurriculumCorner> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: curriculumCorner_main(),
    );
  }
}

class curriculumCorner_main extends StatefulWidget {
  curriculumCorner_main({super.key});

  @override
  State<curriculumCorner_main> createState() => _curriculumCorner_mainState();
}

class _curriculumCorner_mainState extends State<curriculumCorner_main> {
 
  var te = false;
  var tech;

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef = FirebaseDatabase.instance.ref("users/");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
     

      final userData = event.snapshot.value;

      

      setState(() {
        if (userData != null && userData is Map<Object?, Object?>) {
          userData.forEach((key, value) {
            User? user = auth.currentUser;
            String uid = user!.uid;

            if (uid == key) {
              print(
                  "$key-----------------------------------------------$value");
              if (value != null && value is Map<Object?, Object?>) {
                value.forEach((key, value) {
                  if (value != null && value is Map<Object?, Object?>) {
                    //  User? user = auth.currentUser;
                    //   String uid = user!.uid;
                    // var datav = value['staftype'];
                    //  value.forEach((key,value){
                    //  if( value != null && value is Map<Object?,Object?>){
                      if(value['staff'] == "true" && value['status']=="null"){
                        te = true;
                        
                        

                      }
                      else if(
                        value['staff'] == "true" && value['status']=="accept"
                      )
                      {
                        te=false;
                        tech=true;

                      }
                      
                      

                      

                    print(value['fname']);
                  }
                });
              }
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          User? user = snapshot.data;
          if (user == null) {
            return login();
          } else {
            
            if (user!.uid == "yGeLxeHs6IMQJqIGCQsQKLWAebi2")
            {
              return admin_home();
            } 
            else if(te == true) 
            {
              return teacher_home_before();
            }
            else if(tech == true && te==false) 
            {
               return teacher_home();
            }

            else{
              return home();
            }
          


            
          }
        });
  }
}
