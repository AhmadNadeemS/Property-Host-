import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:signup/MainScreenUsers.dart';
import 'package:signup/main_screen.dart';
import 'package:signup/signup.dart';

class RoleCheck extends StatefulWidget {
  @override
  _RoleCheckState createState() => _RoleCheckState();

}

class _RoleCheckState extends State<RoleCheck> {
  //RoleCheck(this.isAdmin);
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isAdmin = false;

  Future<FirebaseUser> getUser() {

    return _auth.currentUser();

  }

  FirebaseUser user;

  @override

  void initState() {

    super.initState();

    initUser();

  }

  initUser() async {
    user = await _auth.currentUser();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//        appBar: AppBar(title: Text('Home ${user.email}'),),

    body: user != null  ? Container(

    child: StreamBuilder<DocumentSnapshot>(

    stream: Firestore.instance.collection('users').document(user.uid).snapshots(),

    builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {

    if (snapshot.hasError) {

    return Text('Error: ${snapshot.hasError}');

    }

    print(user.uid);

    return snapshot.hasData

    ? _checkRole(snapshot.data)

        : Text('No Data');

    })
    )

        : Center(child: Text("Error")),
    );

  }

_checkRole(DocumentSnapshot snapshot) {

    if (snapshot.data['role'] == 'admin') {

      //isAdmin =true;
      print('admin');
      //MainScreen(isAdmin: true,);
      return MainScreen(isAdmin: true,);
      //return MainScreen(isAdmin);

    } else {
     //isAdmin= false;
      print('other');
      //return MainScreen();
     return MainScreen(isAdmin: false,);

    }

  }
}

