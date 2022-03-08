import 'package:brew_crew/Services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Register.dart';
import 'package:brew_crew/loading_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}



class _SignInScreenState extends State<SignInScreen> {
  var  _auth = AuthService();
  String email ="";
  String pass  ="";
  String error ="";
  var _formKey = GlobalKey<FormState>();
  var loading = false ;
  @override
  Widget build(BuildContext context) {

    return loading? Load(): Scaffold(
      backgroundColor: Colors.brown[200],
      appBar:  AppBar (
        backgroundColor: Colors.brown,
        title: Center(
          child: Text(
            "Sign in"
          ),
        ),
        actions: [
          TextButton.icon(onPressed: (){
            Navigator.push(context,     MaterialPageRoute(builder: (context) => Register()),);
          }, icon: Icon(Icons.account_circle_rounded, color: Colors.black), label: Text("Register",style: TextStyle(color: Colors.black),))
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: (val) => val!.isEmpty?'You should not let this empty bro': null,
                decoration: InputDecoration(
                  labelText: "Username",
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (value){
                  setState(() {
                    email = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              TextFormField(
                validator: (val) => val!.length < 6?'the password is even shorter than your penis bro': null,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: Icon(Icons.lock),
                ),
                onChanged: (value){
                  setState(() {
                    pass = value;
                  });
                },
              ),
              SizedBox(height: 10,),
              ElevatedButton(onPressed: () async {
                if(_formKey.currentState!.validate()){
                  setState(() {
                    loading = true;
                  });
                  var User = await _auth.signInE(email, pass);
                  if (User == null){
                    print ("eiii");
                    setState(() {
                      error = _auth.error;
                      loading = false;
                    });
                  }
               }
                else print ("brooooo");
              }, child: Text("Sign in"),style: ElevatedButton.styleFrom(primary: Colors.redAccent,)),
              SizedBox(height: 10,),
              Text(error,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
            ],
          ),
        ),
      )
      // Container (
      //   padding:  EdgeInsets.symmetric(vertical: 30,horizontal: 50),
      //   child: ElevatedButton(
      //     child: Text("Sign in as anounymous"),
      //     onPressed: () async {
      //       dynamic user = await _auth.SignInAnon();
      //         if (user != null){
      //            print ("User signed in ");
      //            print (user.id);
      //         }
      //         else  print ("error signing in");
      //
      //     },
      //   )
      // )
    ) ;
  }
}
