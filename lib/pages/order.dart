import 'package:curriculum_corner/pages/request_details.dart';
import 'package:curriculum_corner/pages/user_search.dart';
import 'package:curriculum_corner/pages/user_search_book.dart';
import 'package:curriculum_corner/pages/user_update_book.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';



class order extends StatefulWidget {
  
   final String id;
   final Object bookid;
   final Map line1;
   
  const order({
    
    required this.id,
    required this.bookid,
    required this.line1,
  });

  @override
  State<order> createState() => _orderState();
}

class _orderState extends State<order> {

     var idlist=[];
     List bookname=[];

   @override
  void initState() {
    super.initState();
    fetchbook(widget.bookid);

 


  }
   

  void fetchbook(bid) async{

    DatabaseReference categoryDataRef =
        FirebaseDatabase.instance.ref("book");

   await categoryDataRef.onValue.listen((DatabaseEvent event) {
    

      final Questionsref = event.snapshot.value;
      print("::::::::::::::::::::${Questionsref}");

      setState(() {
        if (Questionsref != null && Questionsref is Map<Object?, Object?>) {
          Questionsref.forEach((key, value) async {
             idlist.add(key);
            if (value != null && value is Map<Object?, Object?>) {
              if(value['book_id']==bid){
                bookname.add(value["booktitile"]);

              
               



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
        
        
         GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 15.0,
              mainAxisSpacing: 15.0,
            ),
            itemCount: bookname.length,
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

                line1:bookname[index],
                // booknam:bookname[index]


                // name:requests[index]['line1'].toString(),
                //  address:requests[index]['line2'].toString(),
                //   pin:requests[index]['pincode'].toString(),
                //    phone:requests[index]['number'].toString(),
                //    bookid:requests[index]['book_id'].toString(),
                
               
              );
            },
          ),
        
      ],
    ),
  ),
);
  }
}


class MyCard extends StatelessWidget {
  // final String title;
  // final String pin;
  // final String phone;
  // final String address;
  // final String name;
   final String id;
  //  final Object bookid;
   final Map line1;
   

  MyCard({
    // required this.title,
    // required this.pin,
    // required this.phone,
    // required this.address,
    // required this.name,
    required this.id,
    // required this.bookid,
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
                      "address :"+"${line1}",
                       
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
//                         Padding(
//               padding: const EdgeInsets.only(top: 6,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[
//                   Column(
//                     children: [
//                        Text(
//                       "From :"+"${line1["line2"]}",
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
//                       "pin:"+" " +"${line1['pincode']}",
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
//                       "no: "+" " +"${line1['number']}",
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
//              SizedBox(height: 20,),
            
//             Padding(
//               padding: const EdgeInsets.only(top: 10,left: 10),
//               child: Row(
                
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children:[

//                    SizedBox(
//                         width: 90,
//                         height: 25, 
                        
//                         child: ElevatedButton(
//                           onPressed: ()  {

                           
//                           },
//                           style: ButtonStyle(
//                             backgroundColor: MaterialStateProperty.all<Color>(
//                                 Color.fromARGB(255, 203, 2, 2)),
//                           ),
//                           child: Text("details",
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ),
                  
                  

//                   SizedBox(width: 39),
                 
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
              
           
            ],
          ),
        ),
      ),
    );
  }
  
}