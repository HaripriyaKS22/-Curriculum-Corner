// import 'package:curriculum_corner/pages/user_search.dart';
// import 'package:curriculum_corner/pages/user_search_book.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';

// class orders extends StatefulWidget {
 

//   orders();

//   @override
//   State<orders> createState() =>_ordersState();
// }

// class _ordersState extends State<orders> 
// {
//   List books = [];
//   List userid=[];

//   var educationdic = {};
//   var pricedic = {};
//   var authordic = {};
//   var bookimage = {};
//   var Materialpdf = {};
//   var useriddic={};
//    var idlist=[];


//    var line1dic={};
//       var line2dic={};
//          var pincodedic={};
//             var numberdic={};


//    List<String> education = [];
//   var selectededu;

//    FirebaseAuth auth = FirebaseAuth.instance;

//   @override
//   void initState() {
//     super.initState();

 
// fetrequest();
   


    
//   }
   

//   // void fetchbook() async{
//   //   DatabaseReference categoryDataRef =
//   //       FirebaseDatabase.instance.ref("book");

//   //  await categoryDataRef.onValue.listen((DatabaseEvent event) {
//   //     books.clear();

//   //     final Questionsref = event.snapshot.value;
//   //     print("::::::::::::::::::::${Questionsref}");

//   //     setState(() {
//   //       if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
//   //         Questionsref.forEach((key, value) async {
//   //            idlist.add(key);
//   //           if (value != null && value is Map<Object?, Object?>) {
            
//   //               print(
//   //                   "yesssssssssssssssssssssssssssssssssssssssssssR${value['name']}");
//   //               var datav = value['booktitile'];
//   //               books.add(datav);
//   //               var educationn = value['education'];
//   //               var price = value['price'];
//   //               var authorr=value['author'];
//   //               var userid=value['uid'];

                
                

//   //               try {
//   //                 var Reference = FirebaseStorage.instance
//   //                     .ref()
//   //                     .child("book-image/${datav.toString()}");
//   //                 var tempurl = await Reference.getDownloadURL();
//   //                 setState(() {
//   //                   bookimage[datav] = tempurl;
//   //                   educationdic[datav] = educationn;
//   //                   pricedic[datav] = price;
//   //                   authordic[datav]=authorr;
//   //                   useriddic[datav]=userid;
//   //                 });
//   //               } catch (e) {
//   //                 print(e);
//   //               }
              
//   //           }
//   //         });
//   //       }
//   //     });
//   //   });
//   // }


//     void fetrequest() async{

//       User? user = auth.currentUser;
//       String uid = user!.uid;
      
//     DatabaseReference categoryDataRef =
//         FirebaseDatabase.instance.ref("request");

//    await categoryDataRef.onValue.listen((DatabaseEvent event) {
//       books.clear();

//       final Questionsref = event.snapshot.value;
//       print("::::::::::::::::::::${Questionsref}");

//       setState(() {
//         if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
//           Questionsref.forEach((key, value) async {
            
//             if (value != null && value is Map<Object?, Object?>) {

//               if(uid==value['ownerid']  && value["staus"]=="requseted"){

//                  idlist.add(key);
                


//                  var datav = value['uid'];
//                 userid.add(datav);
                

//                 var line1 = value['line1'];

//                 var line2 = value['line2'];
//                 var pincod=value['pincode'];
//                 var number=value['number'];
             
//                 try {
                  
//                   setState(() {
                   
//                     line1dic[datav] = line1;
                    
//                     line2dic[datav] = line2;
//                     pincodedic[datav]=pincod;
//                     numberdic[datav]=number;
//                   });
//                 } catch (e) {
//                   print(e);
//                 }

//               }
            
        
               
              
//             }
//           });
//         }
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
 
//   body: Container(
    
//     child: Column(
//       children: [
//         Container(
//               width: double.infinity,
//               height: 100,
//               decoration: BoxDecoration(
//                 boxShadow: [
//         BoxShadow(
//           color: const Color.fromARGB(255, 193, 185, 185).withOpacity(0.5), 
//           spreadRadius: 5, 
//           blurRadius: 7, 
//           offset: Offset(0, 4), 
//         ),
//             ],
//                color: Colors.white,
//                 borderRadius: BorderRadius.only(
//                   bottomLeft:
//                       Radius.circular(20), 
//                   bottomRight:
//                       Radius.circular(20), 
//                 ),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Row(children: [
//                   Row(
//                     children: [
//                       SizedBox(height: 20,),
//                        GestureDetector(
//                           onTap: () {
//                             Navigator.of(context).pop();
//                           },
//                           child: Icon(
//                             Icons.arrow_back_ios_new,
//                             color: const Color.fromARGB(255, 0, 0, 0),
//                           ),
//                         ),
                      

//                      ClipRRect(
//   borderRadius: BorderRadius.circular(20.0),
//   child: Image.asset(
//     "lib/assets/logo2.png",
//     width: 100, // Change width to desired size
//     height: 100, // Change height to desired size
//     fit: BoxFit.contain, // Use BoxFit.contain to maintain aspect ratio
//   ),
// ),

//                    SizedBox(width: 190,),
                      
//                     ],
//                   ),
//                 ]),
//               ),
//             ),
//             SizedBox(height: 20,),
           
//               SizedBox(height: 20,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Container(
               
//                 height: 1,
//                 width: 60,
//                 color: Color.fromARGB(255, 215, 201, 201),
              
//               ),
//               SizedBox(width: 4),
//               Text("Choose Your Own Way",style: TextStyle(
//                color: Color.fromARGB(255, 215, 201, 201),
                
//               ),),
//                SizedBox(width: 4),
//               Container(
               
//                 height: 1,
//                 width: 60,
//                 color: Color.fromARGB(255, 215, 201, 201),
              
//               ),


//               ],
//             ),
//         Expanded(
//           child: GridView.builder(
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               crossAxisSpacing: 15.0,
//               mainAxisSpacing: 15.0,
//             ),
//             itemCount: userid.length,
//             itemBuilder: (context, index) {
//               return MyCard(
//                 // title: books[index].toString(),
//                 // education: educationdic[books[index].toString()].toString(),
//                 // price: pricedic[books[index].toString()].toString(),
//                 // author:authordic[books[index].toString()].toString(),

//                 // photo: bookimage[books[index].toString()] ?? '',
//                 //  userid:useriddic[books[index].toString()].toString(),
//                 id:idlist[index],


//                 line1:line1dic[userid[index].toString()].toString(),
//                 line2:line2dic[userid[index].toString()].toString(),
//                 pincod:pincodedic[userid[index].toString()].toString(),
//                 number:numberdic[userid[index].toString()].toString()
               
//               );
//             },
//           ),
//         ),
//       ],
//     ),
//   ),
// );

//   }
// }

// class MyCard extends StatelessWidget {
//   // final String title;
//   // final String photo;
//   // final String education;
//   // final String price;
//   // final String author;
//    final String id;
//   //  final String userid;
//    final String line1;
//    final String line2;
//    final String pincod;
//    final String number;

//   MyCard({
//     // required this.title,
//     // required this.photo,
//     // required this.price,
//     // required this.education,
//     // required this.author,
//     required this.id,
//     // required this.userid,
//     required this.line1,
//     required this.line2,
//     required this.pincod,
//     required this.number,


//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       child: InkWell(
//         onTap: () {
//           //  Navigator.push(context, MaterialPageRoute(builder: (context)=>book_big_view(id:id)));

          
//         },
//         child: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(10),
//             gradient: LinearGradient(
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//               colors: [
//                 Color.fromARGB(255, 255, 255, 255),
//                 Color.fromARGB(255, 255, 255, 255)
//               ],
//             ),
//           ),
//           child: Column(
            
            
//             children: [
//             // Container(
              
//             //   padding: EdgeInsets.only(top: 20),
//             //   child: Image.network(photo.toString(),width: 50.0,height: 50.0,)),

          
              
                
//             Padding(
//               padding: const EdgeInsets.only(top: 6,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
//                        Text(
//                       "From :"+"$line1"+"-"+"$line2",
//                       style: TextStyle(
                        
//                         fontSize: 15,
                        
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
                    

//                     ],
//                   )
                 
//                 ] 
//               ),
//             ),
             
//              Padding(
//               padding: const EdgeInsets.only(top: 6,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
                     
//                      Text(
//                       "pin:"+" " +"$pincod",
//                       style: TextStyle(
                        
//                         fontSize: 10,
//                         color: Color.fromARGB(255, 24, 151, 17),
                        
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     ],
//                   )
                 
//                 ] 
//               ),
//             ),
//              Padding(
//               padding: const EdgeInsets.only(top: 6,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
                     
//                      Text(
//                       "no: "+" " +"$number",
//                       style: TextStyle(
                        
//                         fontSize: 12,
//                         color: Color.fromARGB(255, 24, 151, 17),
                        
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),

//                     ],
//                   )
                 
//                 ] 
//               ),
//             ),
//              SizedBox(height: 40,),
//             Padding(
//               padding: const EdgeInsets.only(top: 10,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
                  
                  

//                   SizedBox(width: 115),
                 
//                   Column(
//                     children: [
                     
//                      GestureDetector(
//                  onTap: ()  async{

//                      DatabaseReference ref =
//                                   FirebaseDatabase.instance.ref("request");
                             

//                               await ref.update({
//                                 "${id.toString()}/status":"reject",
                                

                                
//                               });
   
    
//                  },
//   child: ClipRRect(
//     borderRadius: BorderRadius.circular(20.0),
//     child: Image.asset(
//       "lib/assets/delete.png",
//       width: 17,
//       height: 17,
//       fit: BoxFit.cover,
//     ),
//   ),
// ),


//                     ],
//                   )
                  
                
                
                 
//                 ] 
//               ),
//             ),
              
           
//             ],
//           ),
//         ),
//       ),
//     );
//   }
  
// }