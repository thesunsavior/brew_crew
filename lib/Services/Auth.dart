import 'package:brew_crew/Services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/Models/User.dart';
import 'package:flutter/material.dart';

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var error ="";

  cuser? Cuserize (User?  a){
      if (a != null)  return cuser (id:a.uid);
      else return null;
  }

  Stream<cuser?> get loginState {
      return _auth.authStateChanges().map(Cuserize);
  }

  //sign in anounymously
  Future  SignInAnon() async{
    try{
      UserCredential result =  await _auth.signInAnonymously();
      var user  = result.user;
      if (user != null)
        return cuser(id: user.uid) ;
      else return null ;
    }catch (e){
      print("gay~");
      error= e.toString();
      return null;
    }
  }
  // sign in with email and passWord

  // register
  Future registerE(String email, String password) async {
    try{
      UserCredential result =  await _auth.createUserWithEmailAndPassword(email: email, password: password);
      var user = result.user;

      await DataBaseService (uid: user!.uid).UpdateUserData('0','temp',100);

      return Cuserize(user);
    }catch(e){
        print (e.toString());
        error = e.toString();
        return null;
    }
  }
  //sign in
  Future signInE (String email, String password) async{
    try{
      UserCredential result =  await _auth.signInWithEmailAndPassword(email: email, password: password);
      var user = result.user;
      return Cuserize(user);
    }
    catch(e){
      error = e.toString();
      return null;
    }
  }
  //sign out
  Future signOut() async{
    try {
      return await _auth.signOut();
    } catch(e){
      print("welp still in ");
      error = e.toString();
    }
  }
}