import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/Models/Brew.dart';
import 'package:brew_crew/Screen/Home/BrewTile.dart';
class Brew_List extends StatelessWidget {
  const Brew_List({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>?>(context);

    return ListView.builder(
      itemCount: brews!.length,
      itemBuilder: (BuildContext context, int index) {
        return BrewsTile(obj: brews[index]);
    },
    );
  }
}
