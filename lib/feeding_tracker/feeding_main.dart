import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:uuid/uuid.dart';

import '../components/primary_appbar.dart';

class Feeding_Main extends StatelessWidget {
  const Feeding_Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const Feeding(),
    );
  }
}

class Feeding extends StatefulWidget {
  const Feeding({super.key});

  @override
  State<Feeding> createState() => _FeedingState();
}

class _FeedingState extends State<Feeding> {
  String uid = FirebaseAuth.instance.currentUser!.uid;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Track Baby's Feeding"),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Breastfeeding"),
                Tab(text: "Bottle"),
                Tab(text: "Pump"),
              ],
            ),
          ),
          body: TabBarView(
            children: [Breastfeeding(uid: uid), Bottle(), Pump()],
          )),
    );
  }
}

class Breastfeeding extends StatefulWidget {
  Breastfeeding({super.key, required this.uid});
  String uid;
  @override
  State<Breastfeeding> createState() => _BreastfeedingState(uid: uid);
}

class _BreastfeedingState extends State<Breastfeeding> {
  late Stopwatch leftStopwatch, rightStopwatch;
  late Timer left_t, right_t;
  String leftButtonText = "Start", rightButtonText = "Start";
  String uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  _BreastfeedingState({required this.uid});

  void handleLeftStartStop() {
    if (leftStopwatch.isRunning) {
      leftStopwatch.stop();
      setState(() {
        leftButtonText = "Start";
      });
    } else {
      leftStopwatch.start();
      setState(() {
        leftButtonText = "Stop";
      });
    }
  }

  void handleRightStartStop() {
    if (rightStopwatch.isRunning) {
      rightStopwatch.stop();
      setState(() {
        rightButtonText = "Start";
      });
    } else {
      rightStopwatch.start();
      setState(() {
        rightButtonText = "Stop";
      });
    }
  }

  String returnLeftFormattedText() {
    var milli = leftStopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");

    return "$minutes:$seconds";
  }

  String returnRightFormattedText() {
    var milli = rightStopwatch.elapsed.inMilliseconds;

    String milliseconds = (milli % 1000).toString().padLeft(3, "0");
    String seconds = ((milli ~/ 1000) % 60).toString().padLeft(2, "0");
    String minutes = ((milli ~/ 1000) ~/ 60).toString().padLeft(2, "0");

    return "$minutes:$seconds";
  }

  @override
  void initState() {
    super.initState();
    leftStopwatch = Stopwatch();
    rightStopwatch = Stopwatch();

    left_t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });

    right_t = Timer.periodic(Duration(milliseconds: 30), (timer) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 25,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Column(
            children: [
              Text("Left Side",
                  style: TextStyle(fontFamily: 'Inria', fontSize: 20)),
              Container(
                padding: EdgeInsets.all(15),
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.pink[300]!,
                    width: 4,
                  ),
                ),
                child: Text(
                  returnLeftFormattedText(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CupertinoButton(
                onPressed: () {
                  handleLeftStartStop();
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  leftButtonText,
                  style: TextStyle(
                    color: Colors.pink[300]!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  leftStopwatch.reset();
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.pink[300]!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text("Right Side",
                  style: TextStyle(fontFamily: 'Inria', fontSize: 20)),
              Container(
                padding: EdgeInsets.all(15),
                height: 150,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.pink[300]!,
                    width: 4,
                  ),
                ),
                child: Text(
                  returnRightFormattedText(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              CupertinoButton(
                onPressed: () {
                  handleRightStartStop();
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  rightButtonText,
                  style: TextStyle(
                    color: Colors.pink[300]!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: () {
                  rightStopwatch.reset();
                },
                padding: EdgeInsets.all(0),
                child: Text(
                  "Reset",
                  style: TextStyle(
                    color: Colors.pink[300]!,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ]),
        Container(
          alignment: Alignment.center,
          child: CupertinoButton(
            alignment: Alignment.center,
            onPressed: () async {
              print(uid);
              String feedID = const Uuid().v1();
              await _firestore
                  .collection('users')
                  .doc(uid)
                  .collection('feeds')
                  .doc(feedID)
                  .collection('breastfeeding')
                  .doc(feedID)
                  .set({
                'date': DateTime.now(),
                'left': leftStopwatch.elapsed.inSeconds,
                'right': rightStopwatch.elapsed.inSeconds
              }).then((value) {
                leftStopwatch.reset();
                rightStopwatch.reset();
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
        SizedBox(height: 20),
        Divider(
          color: Colors.pink[300],
        ),
        SizedBox(height: 20),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'History',
            style: TextStyle(
              fontFamily: 'Inria',
              fontSize: 24
            ),
            textAlign: TextAlign.left,
          ),
        ),
      //   SizedBox(
      //     height: 500,
      //     child: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('posts')
      //       .doc(widget.postId)
      //       .collection('comments')
      //       .snapshots(),
      //   builder: (context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }

      //     return ListView.builder(
      //       itemCount: snapshot.data!.docs.length,
      //       itemBuilder: (ctx, index) => CommentCard(
      //         snap: snapshot.data!.docs[index],
      //       ),
      //     );
      //   },
      // ),
      //   )
      ],
    ));
  }
}

class Bottle extends StatefulWidget {
  const Bottle({super.key});

  @override
  State<Bottle> createState() => _BottleState();
}

class _BottleState extends State<Bottle> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class Pump extends StatefulWidget {
  const Pump({super.key});

  @override
  State<Pump> createState() => _PumpState();
}

class _PumpState extends State<Pump> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
