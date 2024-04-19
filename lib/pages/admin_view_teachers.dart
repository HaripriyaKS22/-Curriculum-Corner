import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class view_Teachers extends StatefulWidget {
  const view_Teachers({super.key});

  @override
  State<view_Teachers> createState() => _view_TeachersState();
}

class _view_TeachersState extends State<view_Teachers> {
  List idList = [];
  List mainid = [];
  List subid = [];
  var fname = {};
  var lname = {};
  var email = {};
    var status;

  var institut = {};
  var keymap = {};

  var categoryimageurl = {};
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef = FirebaseDatabase.instance.ref("users");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      idList.clear();

      categoryimageurl.clear();

      final TeacherData = event.snapshot.value;

      setState(() {
        if (TeacherData != null && TeacherData is Map<Object?, Object?>) {
          TeacherData.forEach((key, value) async {
            //  User? user = auth.currentUser;
            //   String uid = user!.uid;

            mainid.add(key);
            print("2222222222222222222222222222222222222222222---${mainid}");

            if (value != null && value is Map<Object?, Object?>) {
              value.forEach((key, value) async {
                var keyss = key;
                subid.add(key);
                print("2222222222222222222222222222222222222222222---${subid}");
                if (value != null && value is Map<Object?, Object?>) {
                  if (value['staff'] == "true") {
                    var datav = value['phonenumber'];
                    idList.add(datav);
                    print("datavvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv$idList");

                    var fnamee = value['fname'];
                    var lnamee = value['lname'];
                    var emaill = value['email'];
                    var institutionn = value['institute'];

                    try {
                      var Reference = FirebaseStorage.instance
                          .ref()
                          .child("Teachers-id-image/${fnamee.toString()}");
                      var tempurl = await Reference.getDownloadURL();
                      setState(() {
                        categoryimageurl[datav] = tempurl;
                        fname[datav] = fnamee;
                        lname[datav] = lnamee;
                        email[datav] = emaill;
                        institut[datav] = institutionn;
                        keymap[datav] = keyss;

                        //print("keymapppppppppp-----------------------------${ keymap[datav]}");
                      });
                    } catch (e) {
                      print("e");
                    }
                  }
                }
              });
            }
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Teachers",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: Color(0xFFA3213C),
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemCount: idList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyCard(
                phone: idList[index].toString(),
                first_name: fname[idList[index].toString()].toString(),
                last_name: lname[idList[index].toString()].toString(),
                email: email[idList[index].toString()].toString(),
                institute: institut[idList[index].toString()].toString(),
                photo: categoryimageurl[idList[index].toString()].toString(),
                mainid: mainid[index],
                subid: subid[index],
              ),
            );
          },
        ),
      ),
    );
  }
}

class MyCard extends StatefulWidget {
  final String first_name;
  final String photo;
  final String phone;
  final String last_name;
  final String email;
  final String institute;
  final String mainid;
  final String subid;
  MyCard(
      {required this.first_name,
      required this.photo,
      required this.last_name,
      required this.phone,
      required this.email,
      required this.institute,
      required this.mainid,
      required this.subid});

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  var categoryimageurl;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 250,
        child: Card(
          elevation: 3,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromARGB(255, 228, 228, 228),
                  Color.fromARGB(255, 253, 226, 246)
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            
                               
                                widget.first_name +
                                " " +
                                widget.last_name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(
                                  255, 6, 6, 6), // Set text color
                            ),
                          ),
                          Text(
                               widget.email,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(
                                  255, 0, 0, 0), // Set text color
                            ),
                          ),
                          Text(
                             widget.institute,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(
                                  255, 0, 0, 0), // Set text color
                            ),
                          ),
                          Text(
                             widget.phone,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: const Color.fromARGB(
                                  255, 2, 2, 2), // Set text color
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.network(
                            widget.photo.toString(),
                            width: 130.0,
                            height: 150.0,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                            
                         

                          DatabaseReference ref = FirebaseDatabase.instance.ref("users");

                          print(
                              "mainnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn${widget.subid.toString()}/${widget.mainid.toString()}/status");

                          await ref.update({
                            "${widget.mainid.toString()}/${widget.subid.toString()}/status": "accept",
                          });
                        
                        
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => view_Teachers()));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFF49243F)),
                        ),
                        child: Text("Accept",
                            style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () async {

                           DatabaseReference ref = FirebaseDatabase.instance.ref("users");

                         

                          await ref.update({
                            "${widget.mainid.toString()}/${widget.subid.toString()}/status": "reject",
                          });


                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xFFA3213C)),
                        ),
                        child: Text("Reject",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
