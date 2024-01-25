import 'dart:core';
import 'package:flutter/material.dart';
import 'package:gsc2024/postpartum_depression/main.dart';

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
          child: Column(
        children: [
          Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color.fromARGB(255, 218, 242, 206),
              ),
              child: GestureDetector(
                  onTap: () => {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              settings: RouteSettings(name: "/ppd"),
                              builder: (context) => PPDMain()),
                        )
                      },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.bar_chart),
                      SizedBox(height: 10),
                      Text(
                        'Post Partum\n Depression Screening',
                        style: TextStyle(
                          fontFamily: 'Inria',
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Icon(Icons.chevron_right)
                    ],
                  ))),
        ],
      )),
    );
  }
}
