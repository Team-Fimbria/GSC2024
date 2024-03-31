import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teachable/teachable.dart';

class TeachableWidget extends StatefulWidget {
  TeachableWidget({Key? key}) : super(key: key);

  @override
  _TeachableWidgetState createState() => _TeachableWidgetState();
}

class _TeachableWidgetState extends State<TeachableWidget> {
  String pose1 = "", pose2 = "";
  double p1 = 0, p2 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Pose Classifier")),
        body: Stack(
          children: [
            Container(
                child: Column(children: <Widget>[
              Expanded(
                child: Container(
                  child: Teachable(
                    path: "assets/tm.html",
                    results: (res) {
                      var resp = jsonDecode(res);
                      // print("The values are ${}");
                      setState(() {
                        p1 = resp['Left'];
                        p2 = resp['Right'];
                        pose1 = (resp['Left'] * 100.0).round().toString();
                        pose2 = (resp['Right'] * 100.0).round().toString();
                      });
                    },
                  ),
                ),
              ),
            ])),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                // width: double.infinity,
                height: 100,
                padding: EdgeInsets.symmetric(horizontal: 10),
                // decoration: BoxDecoration(
                //   color: Colors.black.withOpacity(0.5),
                // ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Left',
                            style: TextStyle(
                                color: Colors.redAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          flex: 8,
                          child: SizedBox(
                            height: 32.0,
                            child: Stack(
                              children: [
                                LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(15),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.redAccent),
                                  value: p1,
                                  backgroundColor:
                                      Colors.redAccent.withOpacity(0.2),
                                  minHeight: 50.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${pose1} %',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Right',
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontWeight: FontWeight.w600,
                                fontSize: 20.0),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          flex: 8,
                          child: SizedBox(
                            height: 32.0,
                            child: Stack(
                              children: [
                                LinearProgressIndicator(
                                  borderRadius: BorderRadius.circular(15),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orangeAccent),
                                  value: p2,
                                  backgroundColor:
                                      Colors.orangeAccent.withOpacity(0.2),
                                  minHeight: 50.0,
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    '${pose2} %',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
