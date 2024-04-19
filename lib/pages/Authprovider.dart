import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class AuthProvide extends ChangeNotifier{

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
   String? verificationIdimp ;

    Future signphone(String number) async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);

      } ,
      verificationFailed: (FirebaseException e){
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdimp = verificationId;

        print("your code sent sucsessfully");
      },
      codeAutoRetrievalTimeout: (String verificationId)
       {print("your code is time out");}
    );


   }


   Future otpverify( otp, fname, lname,  phone, email) async
   
   {

    // FirebaseAuth database= FirebaseAuth.instance;
   
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdimp!,
       smsCode: otp);
        await auth.signInWithCredential(credential);
        User? user = auth.currentUser;
        String uid = user!.uid;
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
        DatabaseReference newuser = ref.push();

 
  await newuser.set({
    "fname": fname,
    "lname": lname,
    "email" : email,
    "phonenumber": phone,
    
    "staff": "false"
  });
}


  Future Teachers_signphone(String number) async{
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);

      } ,
      verificationFailed: (FirebaseException e){
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        verificationIdimp = verificationId;

        print("your code sent sucsessfully");
      },
      codeAutoRetrievalTimeout: (String verificationId)
       {print("your code is time out");}
    );


   }

 Future Teachers_otpverify( otp, fname, lname,  phone, email,institute) async
   
   {

    // FirebaseAuth database= FirebaseAuth.instance;
   
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdimp!,
       smsCode: otp);
        await auth.signInWithCredential(credential);
        User? user = auth.currentUser;
        String uid = user!.uid;
        
        DatabaseReference ref = FirebaseDatabase.instance.ref("users/$uid");
        DatabaseReference newuser = ref.push();

 
  await newuser.set({
    "fname": fname,
    "lname": lname,
    "email" : email,
    "phonenumber": phone,
    "institute":  institute,
    
    "staff" : "true",
    "status": "null"
    

  });
}

  



   Future loginUser( otp,  phone) async
   
   {

   
    final PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: verificationIdimp!,
       smsCode: otp);
        await auth.signInWithCredential(credential);
       

 
 
}
}