import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class request_details extends StatefulWidget {
  var name;
  var address;
  var pin;
  var phone;
  var bookid;
  var requestid;

  request_details(
      {required this.name,
      required this.address,
      required this.pin,
      required this.phone,
      required this.bookid,
      required this.requestid
      });

  @override
  State<request_details> createState() => _request_detailsState();
}

class _request_detailsState extends State<request_details> {
  List books = [];
  var idlist = [];
  var datav;
  var price;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchbook();
  }

  void fetchbook() {
    DatabaseReference categoryDataRef = FirebaseDatabase.instance.ref("book");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      books.clear();

      final bookref = event.snapshot.value;

      setState(() {
        if (bookref != null && bookref is Map<Object?, Object?>) {
          bookref.forEach((key, value) async {
            idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {
              if (key == widget.bookid) {
                datav = value['booktitile'];
                price = value["price"];
                books.add(value);
              }

              try {
                var Reference = FirebaseStorage.instance
                    .ref()
                    .child("book-image/${datav.toString()}");
                var tempurl = await Reference.getDownloadURL();
                setState(() {});
              } catch (e) {
                print(e);
              }
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
          width: double.infinity,
          height: 1000,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 203, 11, 50),
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
                    topRight: Radius.circular(30)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 55, left: 20, right: 20),
                child: Column(
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                datav,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 25),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                            " $price ₹",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 15),
                          ),
                          SizedBox(
                            height: 10,
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
                                "To",
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
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.name,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.address,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.pin,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.phone,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 13),
                          ),
                          SizedBox(height: 40,),
                           SizedBox(
                        width: 150,
                        height: 25, 
                        
                        child: ElevatedButton(
                          onPressed: ()  async{
                             DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("request");
                             

                              await ref.update({
                                "${widget.requestid.toString()}/status":"accept",
                                

                                
                              });
   

                           
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 203, 2, 2)),
                          ),
                          child: Text("Accept",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                  
                        ],
                      ),
                    )
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
