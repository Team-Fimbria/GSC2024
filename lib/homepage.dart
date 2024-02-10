import 'dart:core';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/pose_estimation/pose_main.dart';
import 'package:gsc2024/postpartum_depression/main.dart';

import 'components/primary_appbar.dart';
// import 'login.dart';

class Home extends StatefulWidget {
  Home({Key? key, required this.mobile_cameras}) : super(key: key);

  late List<CameraDescription> mobile_cameras;

  @override
  State<Home> createState() => _HomeState(mobile_cameras: mobile_cameras);
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  // final CarouselController _controller = CarouselController();

  late List<CameraDescription> mobile_cameras;

  _HomeState({required this.mobile_cameras});

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
                              settings: RouteSettings(name: "/pose_est"),
                              builder: (context) => Pose_Main()),
                        )
                      },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.bar_chart),
                      SizedBox(height: 10),
                      Text(
                        'Pose Estimation',
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
