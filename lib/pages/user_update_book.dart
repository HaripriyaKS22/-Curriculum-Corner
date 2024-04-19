import 'dart:io';

import 'package:curriculum_corner/pages/admin_view_category.dart';
import 'package:curriculum_corner/pages/user_add_books.dart';
import 'package:curriculum_corner/pages/user_view_books.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart';

class update_book extends StatefulWidget {
  var id;
  update_book({required this.id});

  @override
  State<update_book> createState() => _update_bookState();
}

class _update_bookState extends State<update_book> {
  TextEditingController con1 = new TextEditingController();
  TextEditingController con2 = new TextEditingController();
  TextEditingController con3 = new TextEditingController();
  String selectedValue = '';
  List<String> educationlist = [];

  List books = [];
  var datav;
  var price;
  var author;

  var idlist = [];
  FirebaseAuth auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    // Fetch locations from Firebase
    fetchEducation();
    fetchbook();
  }

  void fetchbook() async {
    DatabaseReference categoryDataRef = FirebaseDatabase.instance.ref("book");

    await categoryDataRef.onValue.listen((DatabaseEvent event) {
      books.clear();

      final bookref = event.snapshot.value;
      print("::::::::::::::::::::${bookref}");

      setState(() {
        if (bookref != null && bookref is Map<Object?, Object?>) {
          bookref.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              if (key == widget.id) {
                print(
                    "yesssssssssssssssssssssssssssssssssssssssssssR${value['name']}");
                datav = value['booktitile'];
                books.add(datav);

                price = value['price'];
                author = value['author'];
              }
            }
          });
        }
      });
    });
  }

  var selectedfile;

  void fetchEducation() {
    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("education");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      educationlist.clear();

      final categoryData = event.snapshot.value;

      setState(() {
        if (categoryData != null && categoryData is Map<Object?, Object?>) {
          categoryData.forEach((key, value) async {
            if (value != null && value is Map<Object?, Object?>) {
              var datav = value['education'];
              educationlist.add(datav.toString());
              selectedValue = datav.toString();

              print("${educationlist}");
            }
          });
        }
      });
    });
  }

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
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color.fromARGB(255, 203, 2, 2), Color(0xFF49243F)],
                  ),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: Colors.white,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "Books",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            SizedBox(
                              width: 200,
                            ),
                            PopupMenuButton<String>(
                              itemBuilder: (BuildContext context) =>
                                  <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: 'Books',
                                  child: Row(
                                    children: [
                                      Text('Books'),
                                    ],
                                  ),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (contex) =>
                                                user_view_book()));
                                    print('Button pressed');
                                  },
                                ),
                              ],
                              onSelected: (String value) {
                                // Handle menu item selection here
                                print('You selected: $value');
                              },
                              icon: Icon(Icons.more_vert,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.asset(
                      "lib/assets/addbook.png",
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextField(
                        decoration: InputDecoration(
                            hintText: datav,
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0)),
                            label: Text("Book Titile")),
                        controller: con1,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: con2,
                          decoration: InputDecoration(
                              hintText: author,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("Author"))),
                      SizedBox(
                        height: 20,
                      ),
                      TextField(
                          controller: con3,
                          decoration: InputDecoration(
                              hintText: price,
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 15),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15.0)),
                              label: Text("Price"))),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: 320,
                        height: 50,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InputDecorator(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Select Education',
                            labelText: 'Education',
                            contentPadding:
                                EdgeInsets.symmetric(horizontal: 10),
                          ),
                          child: DropdownButton<String>(
                            value: selectedValue,
                            underline: Container(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedValue = newValue!;
                                print(selectedValue);
                              });
                            },
                            items: educationlist
                                .map<DropdownMenuItem<String>>((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          onPressed: () {
                            bookimageupload();
                          },
                          child: Text("uplaod")),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            addbook();
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 203, 2, 2)),
                          ),
                          child: Text("Add",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void bookimageupload() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles();
      if (result != null) {
        setState(() {
          selectedfile = File(result.files.single.path!);
        });
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("file selected succesfully"),
          backgroundColor: Color.fromARGB(173, 120, 249, 126),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("error while selecting the file"),
        backgroundColor: Colors.red,
      ));
    }
  }

  void addbook() async {
    try {
      User? user = auth.currentUser;
      String uid = user!.uid;

      if (selectedfile != null) {
        await FirebaseStorage.instance
            .ref()
            .child("book-image/${con1.text}")
            .putFile(selectedfile);
      }
      if (con1.text.isNotEmpty && con2.text.isNotEmpty) {
        DatabaseReference ref = FirebaseDatabase.instance.ref("book");
        DatabaseReference newuser = ref.push();

        await newuser.update({
          
          "${widget.id.toString()}/booktitile": con1.text,
          "${widget.id.toString()}/author": con2.text,
          "${widget.id.toString()}/price": con3.text,
          "education": selectedValue
        });
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => add_book()));
      } else {
        print("fill out the fields");
      }
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("file selected succesfully"),
        backgroundColor: Color.fromARGB(173, 120, 249, 126),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("file selected failed"),
        backgroundColor: Color.fromARGB(172, 247, 45, 45),
      ));
    }
  }
}
