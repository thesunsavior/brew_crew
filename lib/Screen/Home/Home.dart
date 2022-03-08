import 'package:brew_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:brew_crew/Services/Auth.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/brew_list.dart';
import 'Setting.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    var _auth = AuthService();
    var user  = Provider.of<cuser?>(context);

    void ShowSettingPanel(){
      showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20,horizontal: 60),
            child: SettingPanel(),
          );
        }
      );
    };
    return
      StreamProvider.value(
        initialData: null,
        value: DataBaseService(uid: user!.id).brews,
        child: Scaffold(
          backgroundColor: Colors.brown[50],
          appBar: AppBar(
            backgroundColor: Colors.brown,
            title: Text ("Home"),
            actions: [
              TextButton.icon(
                  onPressed: () async {
                      await _auth.signOut();
                  },
                  icon: Icon(Icons.person, color: Colors.black54,),
                  label: Text("log out", style: TextStyle(color: Colors.black54),)
              ),
              TextButton.icon(onPressed: (){ShowSettingPanel();}, icon: Icon(Icons.settings,color: Colors.black54),
              label: Text("Settings",style: TextStyle(color:Colors.black54),))
            ],
          ),
          body: Brew_List(),
        ),
      );
  }
}
