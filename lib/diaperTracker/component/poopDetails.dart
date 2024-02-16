import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../components/primary_appbar.dart';
import '../../login.dart';
import '../../homepage.dart';

class Diaper extends StatefulWidget {
  const Diaper({Key? key}) : super(key: key);

  @override
  State<Diaper> createState() => _DiaperState();
}

class _DiaperState extends State<Diaper> {
  int count = 0;

  void incrementCounter() {
    setState(() {
      count++;
    });
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
        child: PrimaryAppBar(
          page: 'homepage',
        ),
        preferredSize: const Size.fromHeight(110.0),
      ),
      
      body: SingleChildScrollView(
        child: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
          
          children: [Container(
            child: Row(mainAxisAlignment: MainAxisAlignment.start,
        
            // alignment: Alignment.center,
            children:[Container(
            child: CupertinoButton( 
              color: Colors.pink[300],
              padding: EdgeInsets.symmetric(horizontal: 20),           
              onPressed: () => {
                incrementCounter()
              },
            child: Text('pee')),),
            
            Container(
            child: CupertinoButton( 
              color: Colors.pink[300],
              padding: EdgeInsets.symmetric(horizontal: 20),           
              onPressed: () => {
                incrementCounter()
              },
            child: Text('poop')),),
            
            Container(
            child: CupertinoButton( 
              color: Colors.pink[300],
              padding: EdgeInsets.symmetric(horizontal: 20),           
              onPressed: () => {
                incrementCounter()
              },
            child: Text('Mixed')),),

            Container(
            child: CupertinoButton( 
              color: Colors.pink[300],
              padding: EdgeInsets.symmetric(horizontal: 20),           
              onPressed: () => {
                incrementCounter()
              },
            child: Text('Dry')),),
          ]),
          ),
          ]),
          ),
          ),
        
    );
  }
}
