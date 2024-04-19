import 'package:curriculum_corner/pages/request_details.dart';
import 'package:curriculum_corner/pages/user_search.dart';
import 'package:curriculum_corner/pages/user_search_book.dart';
import 'package:curriculum_corner/pages/user_update_book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class my_order extends StatefulWidget {
 

  my_order();

  @override
  State<my_order> createState() =>_my_orderState();
}

class _my_orderState extends State<my_order> 
{
  List bookid = [];
  List<Map> requests = [];
  List<Map> books= [];
  List userid=[];

  var educationdic = {};
  var pricedic = {};
  var authordic = {};
  var bookimage = {};
  var Materialpdf = {};
  var useriddic={};
   var idlist=[];
   var bookname= [];
  


   var line1dic={};
      var line2dic={};
         var pincodedic={};
            var numberdic={};


   List<String> education = [];
  var selectededu;

   FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();

 
fetrequest();

// for (int i=0 ;i < requests.length; i++)  
// {
// fetchbook(requests[i]['book_id']);
   
// }
    
  }
   

  // void fetchbook(bid) async{

  //   DatabaseReference categoryDataRef =
  //       FirebaseDatabase.instance.ref("book");

  //  await categoryDataRef.onValue.listen((DatabaseEvent event) {
    

  //     final Questionsref = event.snapshot.value;
  //     print("::::::::::::::::::::${Questionsref}");

  //     setState(() {
  //       if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
  //         Questionsref.forEach((key, value) async {
  //            idlist.add(key);
  //           if (value != null && value is Map<Object?, Object?>) {
  //             if(value['book_id']==bid){
  //               bookname.add(value["booktitile"]);

              
               



  //             }
            
               
              
  //           }
  //         });
  //       }
  //     });  

  //   });
  // }


    void fetrequest() async{

      User? user = auth.currentUser;
      String uid = user!.uid;
      
    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("request");

   await categoryDataRef.onValue.listen((DatabaseEvent event) {
      userid.clear();

      final Questionsref = event.snapshot.value;

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
          Questionsref.forEach((key, value) async {
            
            if (value != null && value is Map<Object?, Object?>) {

              if(uid==value['uid']  ){

                 idlist.add(key);
                
                 requests.add(value);



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
            itemCount: requests.length,
            itemBuilder: (context, index) {
              //var bid=requests[index]['book_id'];

              // var bokkname = fetchbook(bid);

              return MyCard(
                // title: books[index].toString(),
                // education: educationdic[books[index].toString()].toString(),
                // price: pricedic[books[index].toString()].toString(),
                // author:authordic[books[index].toString()].toString(),

                // photo: bookimage[books[index].toString()] ?? '',
                //  userid:useriddic[books[index].toString()].toString(),
                id:idlist[index],

                line1:requests[index],
                // booknam:bookname[index]


                name:requests[index]['line1'].toString(),
                 address:requests[index]['line2'].toString(),
                  pin:requests[index]['pincode'].toString(),
                   phone:requests[index]['number'].toString(),
                   bookid:requests[index]['book_id'].toString(),
                
               
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
  // final String title;
  final String pin;
  final String phone;
  final String address;
  final String name;
   final String id;
   final Object bookid;
   final Map line1;
   

  MyCard({
    // required this.title,
    required this.pin,
    required this.phone,
    required this.address,
    required this.name,
    required this.id,
    required this.bookid,
    required this.line1,
   


  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: InkWell(
        onTap: () {
          //  Navigator.push(context, MaterialPageRoute(builder: (context)=>book_big_view(id:id)));

          
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
            // Container(
              
            //   padding: EdgeInsets.only(top: 20),
            //   child: Image.network(photo.toString(),width: 50.0,height: 50.0,)),

          Padding(
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                    //    Text(
                    //   "BOOK :"+"$booknam",
                    //   style: TextStyle(
                        
                    //     fontSize: 15,
                        
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    

                    ],
                  )
                 
                ] 
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                       Text(
                     "${line1['bookname']}" ,
                       
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
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                       Text(
                     "${line1['line1']}",
                       
                      style: TextStyle(
                        
                        fontSize: 10,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    

                    ],
                  )
                 
                ] 
              ),
            ),
                        Padding(
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                       Text(
                     "${line1['price']} ₹",
                      style: TextStyle(
                        
                        fontSize: 10,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    

                    ],
                  )
                 
                ] 
              ),
            ),
             
             Padding(
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                     
                     Text(
                     "${line1['pincode']}",
                      style: TextStyle(
                        
                        fontSize: 10,
                        color: Colors.black,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ],
                  )
                 
                ] 
              ),
            ),
             Padding(
              padding: const EdgeInsets.only(top: 6,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                  Column(
                    children: [
                     
                     Text(
                     "${line1['number']}",
                      style: TextStyle(
                        
                        fontSize: 10,
                        color:Colors.black,
                        
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    ],
                  )
                 
                ] 
              ),
            ),
             SizedBox(height: 10,),
            
            Padding(
              padding: const EdgeInsets.only(top: 10,left: 10),
              child: Row(
                
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[

                   SizedBox(
                        width: 90,
                        height: 25, 
                        
                        child: ElevatedButton(
                          onPressed: ()  {
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>request_details(name:name,address:address,pin:pin,phone:phone,bookid:bookid,requestid:id)));

                           
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 203, 2, 2)),
                          ),
                          child: Text("details",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                  
                  

                  SizedBox(width: 39),
                 
                  Column(
                    children: [
                     
                     GestureDetector(
                 onTap: ()  async{

                     DatabaseReference ref =
                                  FirebaseDatabase.instance.ref("request");
                             

                              await ref.update({
                                "${id.toString()}/status":"reject",
                                

                                
                              });
   
    
                 },
  child: ClipRRect(
    borderRadius: BorderRadius.circular(20.0),
    child: Image.asset(
      "lib/assets/delete.png",
      width: 17,
      height: 17,
      fit: BoxFit.cover,
    ),
  ),
),


                    ],
                  )
                  
                
                
                 
                ] 
              ),
            ),
              
           
            ],
          ),
        ),
      ),
    );
  }
  
}