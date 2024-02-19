import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/postpartum_depression/utils/chartGradient.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:uuid/uuid.dart';
import '../components/primary_appbar.dart';
// import '../login.dart';
// import '../homepage.dart';

// class Diaper_Main extends StatefulWidget {
//   const Diaper_Main({Key? key}) : super(key: key);

//   @override
//   State<Diaper_Main> createState() => _DiaperState();
// }

class Diaper_Main extends StatefulWidget {
  Diaper_Main({super.key, required this.uid});
  String uid;
  @override
  State<Diaper_Main> createState() => _DiaperState(uid: uid);
}

class _DiaperState extends State<Diaper_Main> {
  int count = 0;
  int? _sliding=0;
  int? _sliding1=0;
  int? _sliding2=0;
  void incrementCounter() {
    setState(() {
      count++;
    });
  }

  String uid = FirebaseAuth.instance.currentUser!.uid;
  // // String uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  // _DiaperState({required this.uid});

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
                Container(child: Text('Content Of Diaper',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),padding:EdgeInsets.all(10)),
                Container(
                  padding:EdgeInsets.fromLTRB(0, 0, 0, 20),
                  // padding:EdgeInsets.fromLTRB(left, top, right, bottom),
                  child:CupertinoSlidingSegmentedControl(
                    padding: EdgeInsets.all(10),
                    children: const{
                      0: Text('Pee',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      1: Text('Poop',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      2: Text('Mixed',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      3: Text('Dry',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                    },
                    groupValue: _sliding1,
                    onValueChanged: (int? newValue){
                      setState((){
                        _sliding1 = newValue;
                      });
                    },
                    backgroundColor: Color.fromARGB(255, 240, 98, 146)),
                    
                ),
                // Container(padding:EdgeInsets.fromLTRB(left, top, right, bottom)),
                Container(child: Text('Color of Content',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),padding:EdgeInsets.all(10)),
                Container(
                  // padding:EdgeInsets.all(20),
                  padding:EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child:CupertinoSlidingSegmentedControl(
                    padding: EdgeInsets.all(10),
                    children: const{
                      0: Text('Yellow',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      1: Text('Brown',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      2: Text('Black',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      3: Text('Green',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                    },
                    groupValue: _sliding,
                    onValueChanged: (int? newValue){
                      setState((){
                        _sliding = newValue;
                      });
                    },
                    backgroundColor: const Color.fromRGBO(240, 98, 146, 1)),
                    
                ),
                Container(child: Text('Consistency',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),padding:EdgeInsets.all(10)),
                Container(
                  // padding:EdgeInsets.all(20),
                  padding:EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child:CupertinoSlidingSegmentedControl(
                    padding: EdgeInsets.all(10),
                    children: const{
                      0: Text('Sticky',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      1: Text('Mushy',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      2: Text('Soft',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                      3: Text('Well Formed',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),
                    },
                    groupValue: _sliding2,
                    onValueChanged: (int? newValue){
                      setState((){
                        _sliding2 = newValue;
                      });
                    },
                    backgroundColor: Color.fromARGB(255, 240, 98, 146)),                    
                ),
                Container(child: Text('Notes',style: TextStyle(
                                          fontSize: 15,                                          
                                        ),),padding:EdgeInsets.all(10)),
                
                Container(
                  padding:EdgeInsets.fromLTRB(20, 15, 0, 20),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink[300]!, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                    child: TextField(
                          // controller: notesEditingController,
                            // autofocus: true,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Add a Note',
                            ),
                          ),
                                    
                ),

                Container(
                  padding:EdgeInsets.fromLTRB(0, 20, 0, 0),
                  alignment: Alignment(0, 0),
                  child: CupertinoButton(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: new Text("Save",
                                    textAlign: TextAlign.center,
                                    style: new TextStyle(color: Colors.pink[300])),                              
                              onPressed: () => {incrementCounter()},),
                )
              ]),
        ),
      ),
    );
  }
}
