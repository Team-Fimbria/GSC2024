import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/diaperTracker/poopHistory.dart';
import 'package:gsc2024/postpartum_depression/utils/chartGradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';
import '../components/primary_appbar.dart';
// import '../login.dart';
// import '../homepage.dart';

class Diaper_Main extends StatefulWidget {
  const Diaper_Main({Key? key}) : super(key: key);

  @override
  State<Diaper_Main> createState() => _DiaperState();
}

// class Diaper_Main extends StatefulWidget {
//   Diaper_Main({super.key, required this.uid});
//   String uid;
//   @override
//   State<Diaper_Main> createState() => _DiaperState(uid: uid);
// }

class _DiaperState extends State<Diaper_Main> {
  int count = 0;
  int? _sliding = 0;
  int? _sliding1 = 0;
  int? _sliding2 = 0;

  String _content = 'Pee';
  String _color = 'Yellow';
  String _consistency = 'Sticky';

  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  String userid() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    return uid;
  }

  // String detail(){
  //   return
  // }
  String uid = FirebaseAuth.instance.currentUser!.uid;
  // // String uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // // _DiaperState({required this.uid});

  final TextEditingController contentEditingController =
          TextEditingController(),
      notesEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Baby's Diaper"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(20),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Container(child: Text(userid())),
                Container(
                    child: Text(
                      'Content Of Diaper',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.all(10)),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  // padding:EdgeInsets.fromLTRB(left, top, right, bottom),
                  child: CupertinoSlidingSegmentedControl(
                      padding: EdgeInsets.all(10),
                      children: const {
                        0: Text(
                          'Pee',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        1: Text(
                          'Poop',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        2: Text(
                          'Mixed',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        3: Text(
                          'Dry',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      },
                      groupValue: _sliding1,
                      onValueChanged: (int? newValue) {
                        setState(() {
                          _sliding1 = newValue;
                          // print(_sliding1);
                          if (_sliding1 == 0) {
                            _content = 'Pee';
                          } else {
                            if (_sliding1 == 1) {
                              _content = 'Poop';
                            } else {
                              if (_sliding1 == 2) {
                                _content = 'Mixed';
                              } else {
                                if (_sliding1 == 3) {
                                  _content = 'Dry';
                                }
                              }
                            }
                          }
                          // print(_sliding1);
                          print(_content);
                        });
                      },
                      backgroundColor: Color.fromARGB(255, 240, 98, 146)),
                ),
                // Container(padding:EdgeInsets.fromLTRB(left, top, right, bottom)),
                Container(
                    child: Text(
                      'Color of Content',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.all(10)),
                Container(
                  // padding:EdgeInsets.all(20),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: CupertinoSlidingSegmentedControl(
                      padding: EdgeInsets.all(10),
                      children: const {
                        0: Text(
                          'Yellow',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        1: Text(
                          'Brown',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        2: Text(
                          'Black',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        3: Text(
                          'Green',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      },
                      groupValue: _sliding,
                      onValueChanged: (int? newValue) {
                        setState(() {
                          _sliding = newValue;
                          if (_sliding == 0) {
                            _color = 'Yellow';
                          } else {
                            if (_sliding == 1) {
                              _color = 'Brown';
                            } else {
                              if (_sliding == 2) {
                                _color = 'Black';
                              } else {
                                if (_sliding == 3) {
                                  _color = 'Green';
                                }
                              }
                            }
                          }
                          // print(_sliding);
                          print(_color);
                        });
                      },
                      backgroundColor: const Color.fromRGBO(240, 98, 146, 1)),
                ),
                Container(
                    child: Text(
                      'Consistency',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.all(10)),
                Container(
                  // padding:EdgeInsets.all(20),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: CupertinoSlidingSegmentedControl(
                      padding: EdgeInsets.all(10),
                      children: const {
                        0: Text(
                          'Sticky',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        1: Text(
                          'Mushy',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        2: Text(
                          'Soft',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        3: Text(
                          'Well Formed',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      },
                      groupValue: _sliding2,
                      onValueChanged: (int? newValue) {
                        setState(() {
                          _sliding2 = newValue;
                          if (_sliding2 == 0) {
                            _consistency = 'Sticky';
                          } else {
                            if (_sliding2 == 1) {
                              _consistency = 'Mushy';
                            } else {
                              if (_sliding2 == 2) {
                                _consistency = 'Soft';
                              } else {
                                if (_sliding2 == 3) {
                                  _consistency = 'Well Formed';
                                }
                              }
                            }
                          }
                          // print(_sliding2);
                          print(_consistency);
                        });
                      },
                      backgroundColor: Color.fromARGB(255, 240, 98, 146)),
                ),
                Container(
                    child: Text(
                      'Notes',
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    padding: EdgeInsets.all(10)),

                Container(
                  padding: EdgeInsets.fromLTRB(20, 15, 0, 20),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.pink[300]!, width: 2),
                      borderRadius: BorderRadius.circular(25)),
                  child: TextField(
                    controller: notesEditingController,
                    // autofocus: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Add a Note',
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  alignment: Alignment.center,
                  child: CupertinoButton(
                    alignment: Alignment.center,
                    onPressed: () async {
                      print(userid());
                      var date = DateTime.now();
                      String Date = "${date.day}-${date.month}-${date.year}";
                      String time =
                          "${date.hour}.${date.minute}.${date.second}";
                      String diaperID = const Uuid().v1();
                      await _firestore
                          .collection('users')
                          .doc(userid())
                          .collection('diaper')
                          .doc(diaperID)
                          .set({
                        'date': Date,
                        'time': time,
                        'content': _content,
                        'color': _color,
                        'consistency': _consistency,
                        'notes': notesEditingController.text!
                      }).then((value) {
                        // int? _sliding = 0;
                        // int? _sliding1 = 0;
                        // int? _sliding2 = 0;

                        // String _content = 'Pee';
                        // String _color = 'Yellow';
                        // String _consistency = 'Sticky';

                        notesEditingController.clear();
                      });
                    },
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    color: Colors.pink[300],
                    borderRadius: BorderRadius.circular(10),
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                Container(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  alignment: Alignment.center,
                  child: CupertinoButton(
                    alignment: Alignment.center,
                    child: Text(
                      'History',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.pink[300],
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            settings: RouteSettings(name: 'poopHistory'),
                            builder: (context) => DiaperHistoryScreen(
                                  uid: uid,
                                )),
                      );
                    },
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
