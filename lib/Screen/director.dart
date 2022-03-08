import 'package:brew_crew/Screen/Authenticate/Authentication.dart';
import 'package:flutter/material.dart';
import 'Home/Home.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Models/User.dart';

class director extends StatelessWidget {
  const director({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var loginState = Provider.of<cuser?> (context);

    if (loginState != null){
      print("user is in");
      print(loginState.id);
      return Home();
    }
    else
    // check if user is signed in ,
    //if yes then to Home
    //else Authenticate screen
    return Authenticate();
  }
}
