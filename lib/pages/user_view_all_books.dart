import 'package:curriculum_corner/pages/book_big_view.dart';
import 'package:curriculum_corner/pages/user_search.dart';
import 'package:curriculum_corner/pages/user_search_book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class user_view_all_books extends StatefulWidget {
 

  user_view_all_books();

  @override
  State<user_view_all_books> createState() =>_user_view_all_booksState();
}

class _user_view_all_booksState extends State<user_view_all_books> 
{
  List books = [];

  var educationdic = {};
  var pricedic = {};
  var authordic = {};
  var bookimage = {};
  var Materialpdf = {};
  var useriddic={};
   var idlist=[];

   List<String> education = [];
  var selectededu;

  @override
  void initState() {
    super.initState();

    fetchcategory();

    fetchbook();

    
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


  void fetchbook() async{
    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("book");

   await categoryDataRef.onValue.listen((DatabaseEvent event) {
      books.clear();

      final Questionsref = event.snapshot.value;
      print("::::::::::::::::::::${Questionsref}");

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
          Questionsref.forEach((key, value) async {
             idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {
            
                
                var datav = value['booktitile'];
                books.add(datav);
                var educationn = value['education'];
                var price = value['price'];
                var authorr=value['author'];
                var userid=value['uid'];

                
                

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("book-image/${datav.toString()}");
                  var tempurl = await Reference.getDownloadURL();
                  setState(() {
                    bookimage[datav] = tempurl;
                    educationdic[datav] = educationn;
                    pricedic[datav] = price;
                    authordic[datav]=authorr;
                    useriddic[datav]=userid;
                  });
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
 
  body: Container(
    
    child: Column(
      children: [
        Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                boxShadow: [
        BoxShadow(
          color: const Color.fromARGB(255, 193, 185, 185).withOpacity(0.5), 
          spreadRadius: 5, 
          blurRadius: 7, 
          offset: Offset(0, 4), 
        ),
            ],
               color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft:
                      Radius.circular(20), 
                  bottomRight:
                      Radius.circular(20), 
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(children: [
                  Row(
                    children: [
                      SizedBox(height: 20,),
                       GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.arrow_back_ios_new,
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                      

                     ClipRRect(
  borderRadius: BorderRadius.circular(20.0),
  child: Image.asset(
    "lib/assets/logo2.png",
    width: 100, // Change width to desired size
    height: 100, // Change height to desired size
    fit: BoxFit.contain, // Use BoxFit.contain to maintain aspect ratio
  ),
),

                   SizedBox(width: 190,),
                      
                    ],
                  ),
                ]),
              ),
            ),
            SizedBox(height: 20,),
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
                                      user_search_book(education: selectededu)));
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
              SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
               
                height: 1,
                width: 60,
                color: Color.fromARGB(255, 215, 201, 201),
              
              ),
              SizedBox(width: 4),
              Text("Choose Your Own Way",style: TextStyle(
               color: Color.fromARGB(255, 215, 201, 201),
                
              ),),
               SizedBox(width: 4),
              Container(
               
                height: 1,
                width: 60,
                color: Color.fromARGB(255, 215, 201, 201),
              
              ),


              ],
            ),
        Expanded(
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            itemCount: books.length,
            itemBuilder: (context, index) {
              return MyCard(
                title: books[index].toString(),
                education: educationdic[books[index].toString()].toString(),
                price: pricedic[books[index].toString()].toString(),
                author:authordic[books[index].toString()].toString(),

                photo: bookimage[books[index].toString()] ?? '',
                userid:useriddic[books[index].toString()].toString(),
                id:idlist[index]
              );
            },
          ),
        ),
      ],
    ),
  ),
);

  }
}

class MyCard extends StatelessWidget {
  final String title;
  final String photo;
  final String education;
  final String price;
  final String author;
   final String id;
   final String userid;

  MyCard({
    required this.title,
    required this.photo,
    required this.price,
    required this.education,
    required this.author,
    required this.id,
    required this.userid,


  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context)=>book_big_view(id:id)));

          
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255, 255, 255, 255),
                Color.fromARGB(255, 255, 255, 255)
              ],
            ),
          ),
          child: Column(
            
            
            children: [
            Container(
              
              padding: EdgeInsets.only(top: 20),
              child: Image.network(photo.toString(),width: 50.0,height: 50.0,)),

          
              
                
            Padding(
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                       Text(
                      "$title",
                      style: TextStyle(
                        
                        fontSize: 15,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    

                    ],
                  )
                 
                ] 
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                     
                     Text(
                     "$education",
                      style: TextStyle(
                        
                        fontSize: 10,
                        color: Color.fromARGB(255, 24, 151, 17),
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ],
                  )
                 
                ] 
              ),
            ),
              Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                     
                     Text(
                      "price:"+" " +"$price₹",
                      style: TextStyle(
                        
                        fontSize: 10,
                        color: Color.fromARGB(255, 24, 151, 17),
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ],
                  )
                 
                ] 
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                     
                     SizedBox(
                        width: 145,
                        height: 25, 
                        
                      
                        child:   ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddressPopupForm(
                    onSubmit: (String line1, String line2, String pincode, String number) {
                  sendrequst(line1, line2, pincode, number);
                },
              );
            },
          );
        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            Color.fromARGB(255, 203, 2, 2),
          ),
        ),
        child: Text(
          "Request",
          style: TextStyle(color: Colors.white),
        ),)
                      ),

                    ],
                  ),
                
                
                 
                ] 
              ),
            ),
              
           
            ],
          ),
        ),
      ),
    );
  }
  
        void sendrequst(String line1, String line2, String pincode, String number) async{
          FirebaseAuth auth = FirebaseAuth.instance;

           User? user = auth.currentUser;
            String uid = user!.uid;
                              
                             
                              DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("request");
                              DatabaseReference newuser = ref.push();

                              await newuser.set({
                                "status": "requested",
                                "uid" : uid,
                                "book_id":id,
                                "bookname" :title,
                                "price":price,
                                "ownerid":userid,
                                "line1": line1,
                                "line2": line2,
                                "pincode": pincode,
                                "number": number

                               


                                
                              });
                             
                            
  }
}

class AddressPopupForm extends StatefulWidget {
  final Function(String, String, String, String) onSubmit;

  const AddressPopupForm({Key? key, required this.onSubmit}) : super(key: key);

  @override
  _AddressPopupFormState createState() => _AddressPopupFormState();
}

class _AddressPopupFormState extends State<AddressPopupForm> {
  final TextEditingController _line1Controller = TextEditingController();
  final TextEditingController _line2Controller = TextEditingController();
  final TextEditingController _pincodeController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Your Address'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _line1Controller,
              decoration: InputDecoration(labelText: 'Address Line 1'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _line2Controller,
              decoration: InputDecoration(labelText: 'Address Line 2'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _pincodeController,
              decoration: InputDecoration(labelText: 'Pincode'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _numberController,
              decoration: InputDecoration(labelText: 'Phone Number'),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the popup
                  },
                  child: Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () {
                    String line1 = _line1Controller.text.trim();
                    String line2 = _line2Controller.text.trim();
                    String pincode = _pincodeController.text.trim();
                    String number = _numberController.text.trim();

                    if (line1.isNotEmpty &&
                        line2.isNotEmpty &&
                        pincode.isNotEmpty &&
                        number.isNotEmpty) {
                      widget.onSubmit(line1, line2, pincode, number); // Pass the data to the callback
                      Navigator.pop(context); // Close the popup
                    } else {
                      // Show an error or prompt the user to fill in all fields
                    }
                  },
                  child: Text('Send'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _line1Controller.dispose();
    _line2Controller.dispose();
    _pincodeController.dispose();
    _numberController.dispose();
    super.dispose();
  }
}
