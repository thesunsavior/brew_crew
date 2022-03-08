import 'package:brew_crew/Services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/Models/User.dart';
import 'package:brew_crew/Services/database.dart';
import 'package:brew_crew/Models/Brew.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class SettingPanel extends StatefulWidget {
  const SettingPanel({Key? key}) : super(key: key);

  @override
  _SettingPanelState createState() => _SettingPanelState();
}

//define
var _formKey = GlobalKey<FormState>();
String? crrNam;
String? crrSugar=null;
int? crrStrength = null;
var loading = false;
List<String> dropDownSugarlist = ['0','1','2','3','4'];

class _SettingPanelState extends State<SettingPanel> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crrSugar=null;
    crrStrength = null;
    crrNam = null;
  }
  @override
  Widget build(BuildContext context) {
    var user  = Provider.of<cuser?>(context);

    return loading? Center(
      child: SpinKitChasingDots(
        color: Colors.brown,
        size: 50.0,
      ),
    ): StreamBuilder<UserData>(
      stream: DataBaseService(uid:user!.id).crrUserData,
      builder: (context,snapshot) {
        if (snapshot.hasData){
          UserData? Udata = snapshot.data;
          return Form(
              key: _formKey,
              child: Column(
                  children:[
                    Text ("Update your coffee state",style: TextStyle(fontSize: 20,color: Colors.brown[800]) ,),
                    SizedBox(height: 20,),
                    TextFormField(
                      initialValue: snapshot.data!.name,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person,color: Colors.yellow[600]),
                          labelText: "Name",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.brown.shade300),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.brown.shade900),
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                      onChanged: (value){
                        setState(() {
                          crrNam = value;
                        });
                      },
                      validator: (val) => val!.isEmpty? "need your name now" : null,
                    ),
                    SizedBox(height: 20,),
                    DropdownButtonFormField(
                      value: crrSugar??snapshot.data!.sugar,
                      decoration: InputDecoration(prefixIcon: Icon(Icons.favorite,color: Colors.pink,),labelText: "Amount of sugar",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.brown.shade300),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 3, color: Colors.brown.shade900),
                            borderRadius: BorderRadius.circular(15),
                          )
                      ),
                      onChanged: (val) {
                        setState(() => crrSugar = val.toString());
                      },
                      items: dropDownSugarlist.map((sugar) {
                        return DropdownMenuItem(
                          child: Text("$sugar cubes of sugar"),
                          value: sugar,
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20,),
                    Text("Coffee strength:",style: TextStyle(color:Colors.brown[800],fontWeight: FontWeight.bold),),
                    Slider(
                      min: 100,
                      max: 900,
                      divisions: 2,
                      activeColor: Colors.brown[crrStrength??snapshot.data!.strength],
                      onChanged: (val){
                        setState(() {
                          crrStrength = val.round();
                        });
                      },
                      value: (crrStrength??snapshot.data!.strength).toDouble(),
                    ),
                    SizedBox(height: 30,),
                    TextButton.icon(onPressed: () async {
                      setState(() {
                        loading = true ;
                      });
                      try {
                        await DataBaseService(uid: user.id).UpdateUserData(
                            crrSugar ?? Udata!.sugar, crrNam ?? Udata!.name,
                            crrStrength ?? Udata!.strength);
                      } catch (e){
                        print (e) ;
                      }
                      setState(() {
                        loading = false ;
                      });
                    }, icon: Icon(Icons.coffee,color: Colors.brown[300],), label: Text("Make your Coffee now"))
                    // DropdownButtonFormField(
                    //        items: dropDownSugarlist.map(
                    //                (sugar){
                    //                  return DropdownMenuItem(
                    //                      value: sugar,
                    //                      child: Text("$sugar cube of sugar(s)")
                    //                  );
                    //                }).toList(),
                    // )
                  ]
              )
          );
        }
        else return CircularProgressIndicator();
      },
    );
  }
}
