import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/Models/Brew.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:brew_crew/Models/User.dart';

class DataBaseService{
  String uid;
  DataBaseService ({required this.uid});
    final CollectionReference brewCol = FirebaseFirestore.instance.collection('brews');


  Future UpdateUserData(String sugar, String name , int Strength) async {
      return await brewCol.doc(uid).set({
        'sugar'   : sugar,
        'name'    :  name ,
        'strength': Strength
      });
  }

  List<Brew>? BrewFromStream (QuerySnapshot snapshot)  {
      return snapshot.docs.map((doc){return Brew(sugar: doc['sugar'], name: doc['name'], strength :doc['strength']);}).toList();
  }

  UserData UserDataFromStream (DocumentSnapshot snapshot) {
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
     return (UserData(uid:uid,name: data['name'], strength: data['strength'],sugar: data['sugar']));
  }

  //streams
  Stream<List<Brew>?> get brews {
    return brewCol.snapshots().map(BrewFromStream);
  }

  Stream<UserData> get crrUserData {
    return brewCol.doc(uid).snapshots().map(UserDataFromStream);
  }

}