import 'package:flutter/material.dart';
import 'package:brew_crew/Models/Brew.dart';

class BrewsTile extends StatelessWidget {

  Brew obj;
  BrewsTile({required this.obj});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.brown[obj.strength],
          ),
          title: Text(obj.name),
          subtitle: Text("Take ${obj.sugar} sugars"),
        ),
      ),
    );
  }
}
