import 'dart:core';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'components/primary_appbar.dart';
import 'login.dart';
import 'diaperTracker/component/poopDetails.dart';
import 'poopTracker.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // final CarouselController _controller = CarouselController();

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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, 
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(),
          Container(
            alignment: Alignment.center,
            child: CupertinoButton( 
              color: Colors.pink[300],
              padding: EdgeInsets.symmetric(horizontal: 20),           
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings:RouteSettings(name: '\diaperTracker\component\poopDetails'),
                    builder: (context) => Diaper())
                 
                );          
              },
              
            child: Text('Diaper Tracker')),
          ),
          // Container(
          //   child: CupertinoButton( 
          //     color: Colors.pink[300],
          //     padding: EdgeInsets.symmetric(horizontal: 25),    
          //     onPressed: () async {
          //       Navigator.of(context).push(
          //         MaterialPageRoute(
          //           settings:RouteSettings(name: '\diaperTracker'),builder: (context) => Diaper())
          //         ) ;  
          //       )              
          //     },
          //   child: Text('Poop Tracker')),
            
          // ),
        ]),
        
      ),
    );
  }
}
