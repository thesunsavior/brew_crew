import 'package:flutter/material.dart';
import 'package:brew_crew/Services/Auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/loading_screen.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}
var  _auth = AuthService();
String email ="";
String pass  ="";
final _formKey = GlobalKey<FormState>();
String error = "";
var loading = false;

class _RegisterState extends State<Register> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    error = "";
  }
  @override
  Widget build(BuildContext context) {
    return loading? Load(): Scaffold(
        backgroundColor: Colors.brown[200],
        appBar:  AppBar (
            backgroundColor: Colors.brown,
            title: Center(
              child: Text(
                  "Sign up"
              ),
            )
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  validator:  (val) => val!.isEmpty? 'you cannot leave this empty': null,
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
                  validator: (val) => val!.length < 6? 'Bro,important stuffs must be long':null,
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
                  if (_formKey.currentState!.validate()){
                      setState(() {
                        loading = true ;
                      });
                      dynamic newUser = await _auth.registerE(email, pass);
                      if (newUser == null){
                        print("eiii");
                        setState(() {
                          error = _auth.error;
                          loading = false ;
                        });
                      }
                      else Navigator.pop(context);
                  }
                  else print("eiii");
                }, child: Text("Submit"),style: ElevatedButton.styleFrom(primary: Colors.redAccent,)),
                SizedBox(height: 10,),
                Text(error,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),),
              ],
            ),
          ),
        )

    ) ;
  }
}
