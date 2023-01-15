
import 'package:about/login.dart';
import 'package:about/navbar.dart';
import 'package:about/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:about/main.dart';

class AuthController extends GetxController {
  //with instance AuthController would be able to the app everywhere
  static AuthController instance = Get.find();
  late Rx<User?> _user;
  FirebaseAuth auth = FirebaseAuth.instance;
 
  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    //our user would be notified
    _user.bindStream(auth.userChanges());
    //worker function
    ever(_user, _initialScreen);
  }

  _initialScreen(User? user) {
    //if user not login
    if (user == null) {
      print("login page");
      Get.offAll(() => HomePage());

    }
    //if user login successfully
    else{
      Get.offAll(() => NavBar(email:user.email!));
      
    }
  }
  //sign up
   void register(String email, password,value)async{
     try{
     await  auth.createUserWithEmailAndPassword(email: email, password: password);
     //snackbar
     Get.snackbar("About Login", "Login message",
           backgroundColor: Color.fromARGB(241, 118, 237, 114),
           snackPosition: SnackPosition.BOTTOM,
           titleText: Text(
             "Login Successful",
             style: TextStyle(
                 color: Colors.white
             ),
           ),
           
       );
     }catch(e){ //if there is a error
        Get.snackbar("About User", "User message",
        backgroundColor: Colors.redAccent,
        snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Account creation failed",
            style: TextStyle(
              color: Colors.white
            ),
          ),
          messageText: Text("$email,$password \n"+
            e.toString(),
              style: TextStyle(
                  color: Colors.white
              )
          )
        );
     }
   }
   //sign in
   void login(String email, password)async{
     try{
       await  auth.signInWithEmailAndPassword(email: email, password: password);
     }catch(e){
       Get.snackbar("About Login", "Login message",
           backgroundColor: Colors.redAccent,
           snackPosition: SnackPosition.BOTTOM,
           titleText: Text(
             "Login failed",
             style: TextStyle(
                 color: Colors.white
             ),
           ),
           
           messageText: Text("$email,$password \n"+
               e.toString(),
               style: TextStyle(
                   color: Colors.white
               )
           )
       );
     }
   }
   //log out
   void logOut()async{
     await auth.signOut();
   }
}
