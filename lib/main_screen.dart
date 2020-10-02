import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:signup/MainScreenUsers.dart';
//import 'package:signup/login.dart';
import 'package:signup/root/root.dart';
import 'package:signup/states/currentUser.dart';
import 'package:flutter/services.dart';

class MainScreen extends StatefulWidget {
  final bool isAdmin;

  const MainScreen({Key key, this.isAdmin}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState(this.isAdmin);
}

class _MainScreenState extends State<MainScreen> {
  bool isPressed = false;
  bool userLoggedIn =false;
  //var _userName;
//  Future<FirebaseUser> getUser() {
//    return _auth.currentUser();
//  }
  Future<String> currentUser() async {
   user = await _auth.currentUser();
    return user != null ? user.uid : null;
  }
  FirebaseUser user;
  @override
  void initState() {
    super.initState();

    initUser();

  }
  String userid;

  initUser() async {
    user = await _auth.currentUser();
    if (user != null) {
      userid = user.uid;
    } else {
      print("user.uid");
      // User is not available. Do something else
    }
    setState(() {});
  }

  bool isAdmin = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //final authData = snapshot.data;
  _MainScreenState(this.isAdmin);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        //backgroundColor: Colors.grey,
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
           //     colors: [Colors.deepPurple, Colors.purple], stops: [0.5, 1.0],
                colors: [Colors.deepPurple, Color(0xff2470c7)], stops: [0.5, 1.0],
              ),
            ),
          ),
          //title: Text('Property Host'),

          centerTitle: true,
          actions: <Widget>[
            Expanded(

              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  //Image.asset('assets/index.jpg', fit: BoxFit.cover,height:16,width:16),
                  Container(
                      margin: new EdgeInsets.only(left: 50),
                      child: Text('Property Host',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),)),

                user!=null ? StreamBuilder(stream: Firestore.instance.collection('users').where("uid", isEqualTo: userid).snapshots(),

      // ignore: missing_return
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.data == null)
          return CircularProgressIndicator();
        //final userDocument = snapshot.data;
        //final title=  snapshot.data.userocument['displayName']);
        //CircularProgressIndicator();
        return Expanded(
          child: ListView.builder(
              itemCount: snapshot.data.documents.length,
              // ignore: missing_return
              itemBuilder: (BuildContext context, int index) {
                String Data= snapshot.data.documents.elementAt(index)['displayName'];
                String Result = Data.substring(0,Data.lastIndexOf(" "));
                //var text = Data.substring(Result, Data.lastIndexOf('') - Result);
                //String ret = Result[0] +""+ Result[1];
                print(user.uid);
                return user != null
                    ? Container(
                  margin: EdgeInsets.only(top: 19, left: 80),
                  child: Text(
                      Result,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontStyle: FontStyle.italic),),
                )
                    : IconButton(
                  icon: Icon(Icons.person),
                  // ignore: missing_return
                  onPressed: () {
                    Navigator.pushNamed(context, '/LoginScreen');
                  },
                );
              }
          ),
        );
      }

                  ):IconButton(
                  icon: Icon(Icons.person),
      // ignore: missing_return
      onPressed: () {
      Navigator.pushNamed(context, '/LoginScreen');
      },
      ),

                ],
              ),
            ),
          ],
          backgroundColor: Colors.teal[600],
          elevation: 0.0,
        ),

        drawer: Theme(
          data: Theme.of(context).copyWith(
  //        canvasColor: Colors.blueGrey,
          ),
           child: user!=null ? Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  height: 120.0,
                  //width: 500,
                  child: DrawerHeader(
                      margin: EdgeInsets.zero,
                      padding: EdgeInsets.zero,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image:  AssetImage('assets/index.jpg'))),
                      child: Stack(children: <Widget>[
                        Positioned(
                            bottom: 1.0,
                            left: 110.0,
                            //top:10,
                            child: Text("Menu",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30.0,
                                    //fontFamily: "Roboto",
                                    fontWeight: FontWeight.w400))),
                      ])),
                ),

                Container(
                  height: 50,
                  //color: Colors.white.withAlpha(128),
                 // color: Colors.grey[800],
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.add_box,color: Colors.green[800],),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Post an Ad"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/PostAdd');
                    },
                  ),
                ),
                //SizedBox(height: 1.0),
                // ignore: unrelated_type_equality_checks
   Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                Container(
                  height: 50,
                  // color: Colors.grey[800],
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.people_outline,color: Colors.green[800],),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Agents List"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/MyProfile');
                    },
                  ),
                ),
                //SizedBox(height: 1.0),
                Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                Center(
                  child: user != null ? Container(
                    height: 50,
                    //color: Colors.grey[800],
                    child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.ac_unit,),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("Agent"),
                          ),
                        ],
                      ),
                      onTap: () {
                        Navigator.pushNamed(context, '/AgentsList');
                      },
                    ),
                  ): SizedBox.shrink(),
                ),
                //SizedBox(height: 1.0),
                Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                Container(
                  height: 50,
                  //color: Colors.grey[800],
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.ac_unit),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Your Ads"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/AdsList');
                    },
                  ),
                ),
                //SizedBox(height: 1.0),
                Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                isAdmin ? Container(
                  height: 50,
                  //color: Colors.grey[800],
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.person,color: Colors.green[800],),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("My Profile"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/UserProfile');
                    },
                  ),
                ):Container(),
                //SizedBox(height: 1.0),
                Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                Container(
                  height: 50,
                  //color: Colors.grey[800],
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.ac_unit),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("Advertise"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/Advertise');
                    },
                  ),
                ),
               //SizedBox(height: 1.0),
                Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                isAdmin ? Container() :Container(
                  height: 50,
                  //color: Colors.grey[800],
                  child: ListTile(
                    title: Row(
                      children: <Widget>[
                        Icon(Icons.check_circle_outline,color: Colors.green[800],),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text("SignUp as Agent"),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/AgentSignup');
                    },
                  ),
                ),
                //SizedBox(height: 1.0),
                Divider(thickness: 0.5,color: Colors.lightBlueAccent,),
                user != null ? Container(
                  height: 50,
                  //color: Colors.grey[800],
                  child: ListTile(
                      title: Row(
                        children: <Widget>[
                          Icon(Icons.person_pin,color: Colors.green[800],),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text("Sign Out"),
                          ),
                        ],
                      ),
                      onTap: ()
                      //      Navigator.pop(context);
                      async {
                        //signOut();
                        // Navigator.pushNamed(context, '/LoginScreen');

                        String _returnString = await _currentUser.signOut();
//                  CurrentUser _currentUser = Provider.of<CurrentUser>(context, listen: false);
//                  String _returnString = await _currentUser.signOut();
                        if (_returnString == 'Success') {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => OurRoot()),
                                (route) => false,
                          );
                          //Navigator.pushNamed(context, '/LoginScreen');
//                  }
//                  //Navigator.pushNamed(context, '/LoginScreen');
                        }
                      }),
                ): SizedBox.shrink(),
              ],
            ),
          ): SizedBox.shrink(),
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Column(
            children: <Widget>[
              Container(
                  height: MediaQuery.of(context).size.height / 1.90,
                  width: 360.0,
                  decoration: BoxDecoration(
                    //borderRadius: BorderRadius.circular(12),
                    //boxShadow: BoxShadow(2),
                    image: DecorationImage(
                      image: AssetImage('assets/front1.jpeg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
//                        Text(
//                          'Find Your Dream Home With Property Host',
//                          textAlign: TextAlign.center,
//                          style: TextStyle(
//                            color: Colors.grey[350],
//                            fontWeight: FontWeight.w900,
//                            fontSize: 30.0,
//                          ),
//                        ),
                        SizedBox(height: 60.0),
                        Container(
                          margin: EdgeInsets.only(top: 120),
                          child: TextField(
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 14.0,
                              letterSpacing: 2.0,
                            ),
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey[700], width: 3.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.grey[100], width: 2.0),
                              ),
                              hintText: 'Enter the Location: ',
                              hintStyle: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 10),
                          child: RaisedButton.icon(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(9.0),
                                side: BorderSide(
                                    color: Colors.pink[500], width: 2.0)),
                            onPressed: () {
                              Navigator.pushNamed(context, '/SearchResult');
                            },
                            icon: Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 12.0,
                            ),
                            label: Text(
                              'Search',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 1.0,
                              ),
                            ),
                            color: Colors.transparent,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}