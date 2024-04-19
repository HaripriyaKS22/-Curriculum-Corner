import 'package:curriculum_corner/pages/user_update_book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class book_big_view extends StatefulWidget {
  var id;
 

  book_big_view({required this.id});

  @override
  State<book_big_view> createState() =>_book_big_viewState();
}

class _book_big_viewState extends State<book_big_view> 
{
  List books = [];
  var datav;
  var education;
  var tempurl;

  var price;
  var author;
  var bookimage = {};
  var idlist=[];

  var Materialpdf = {};

  @override
  void initState() {
    super.initState();

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("book");

    categoryDataRef.onValue.listen((DatabaseEvent event) {
      books.clear();

      final bookref = event.snapshot.value;
     

      setState(() {
        if (bookref != null && bookref is Map<Object?, Object?>) {
          bookref.forEach((key, value) async {

             idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {

              if(key==widget.id){
                print(key);


                setState(() {

                   datav = value['booktitile'];
                                  print("widgeid=======================================${datav}");

              
                education = value['education'];
                price = value['price'];
                author=value['author'];
                
                

                
                  
                });

                try {
                  var Reference = FirebaseStorage.instance
                      .ref()
                      .child("book-image/${datav.toString()}");
                  tempurl = await Reference.getDownloadURL();
                  
                } 
                catch (e) {
                  print(e);
                }

                 

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
          color: const Color.fromARGB(255, 193, 185, 185).withOpacity(0.5), // Color of the shadow
          spreadRadius: 5, // Spread radius
          blurRadius: 7, // Blur radius
          offset: Offset(0, 4), // Offset position of the shadow
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
            Text(datav),
        // Expanded(
        //   child: GridView.builder(
        //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //       crossAxisCount: 2,
        //       crossAxisSpacing: 15.0,
        //       mainAxisSpacing: 15.0,
        //     ),
        //     itemCount: books.length,
        //     itemBuilder: (context, index) {
        //       return MyCard(
        //         title: datav,
        //         educationn: education,
        //         pricee: price,
        //         authorr:author,

        //         photo: tempurl,
        //             id:idlist[index]
        //       );
        //     },
        //   ),
        // ),
      ],
    ),
  ),
);

  }
}

// class MyCard extends StatelessWidget {
//   final String title;
//   final String photo;
//   final String educationn;
//   final String pricee;
//   final String authorr;
//     final String id;  

//   MyCard({
//     required this.title,
//     required this.photo,
//     required this.pricee,
//     required this.educationn,
//     required this.authorr,
//     required this.id
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       elevation: 3,
//       child: InkWell(
//         onTap: () {
//           // Handle tap
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
//             Container(
              
//               padding: EdgeInsets.only(top: 20),
//               child: Image.network(photo.toString(),width: 50.0,height: 50.0,)),

          
              
                
//             Padding(
//               padding: const EdgeInsets.only(top: 6,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
//                        Text(
//                       "$title",
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
//               Padding(
//               padding: const EdgeInsets.only(top: 6,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
                     
//                      Text(
//                       "price:"+" " +"$pricee₹",
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
//             Padding(
//               padding: const EdgeInsets.only(top: 10,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
                     
//                      SizedBox(
//                         width: 90,
//                         height: 25, 
                        
//                         child: ElevatedButton(
//                           onPressed: ()  {
//                               Navigator.push(context, MaterialPageRoute(builder: (context)=>update_book(id:id)));

                           
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color.fromARGB(255, 203, 2, 2)),
//                           ),
//                           child: Text("Edit",
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),

//                     ],
//                   ),
//                  SizedBox(width: 35,),
//                   Column(
//                     children: [
                     
//                      GestureDetector(
//                  onTap: ()  async{

//                    DatabaseReference ref =
//                             FirebaseDatabase.instance.ref("book");
//                             await ref.child(id.toString()).remove();
   
    
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
