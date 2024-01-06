import 'dart:core';
import 'package:flutter/material.dart';

import 'components/primary_appbar.dart';
// import 'login.dart';

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
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          SizedBox(height: 12),
          Container(
            color: Colors.grey[200],
            child: Column(
              children: [
                SizedBox(height: 20),
                Text(
                  "CONTROLLING",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                Container(
                  height: 256,
                  // child: ScrollSnapList(
                  //   padding: EdgeInsets.fromLTRB(16, 12, 16, 12),
                  //   scrollDirection: Axis.horizontal,
                  //   onItemFocus: (index) {
                  //     setState(() {
                  //       _currentIndex = index;
                  //     });
                  //   },
                  //   itemSize: 200,
                  //   dynamicItemSize: true,
                  //   // itemBuilder: (context,_)=> SizedBox(width:12),
                  //   itemBuilder: (context, index) =>
                  //       buildCard(item: items[index]),
                  //   itemCount: 5,
                  //   initialIndex: 0,
                  //   onReachEnd: () => {},
                  // ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
