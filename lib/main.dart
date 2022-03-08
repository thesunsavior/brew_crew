import 'package:brew_crew/Screen/Home/Home.dart';
import 'package:brew_crew/Screen/director.dart';
import 'package:brew_crew/Services/Auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, AsyncSnapshot snapshot){
            //error
            if (snapshot.hasError){
              print ("Damn sthing goes wrong with gg");
            }

            if (snapshot.connectionState == ConnectionState.done)
              return
                StreamProvider.value(
                    initialData: null,
                    value: AuthService().loginState,
                    child: MaterialApp(home: director()),
                );
            else
              return MaterialApp(
                home: Scaffold(
                  body: CircularProgressIndicator(),
                ),
              );
        }
    );
  }
}


