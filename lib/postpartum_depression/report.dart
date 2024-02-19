import 'package:flutter/material.dart';
import 'package:gsc2024/postpartum_depression/main.dart';

const apiKey = "AIzaSyAc8VNOA2zxAJkFsIcAnqdA3gjevglUz8Q";

class Report extends StatelessWidget {
  String response1;
  int score;
  Report({super.key, required this.score, required this.response1});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF96E072)),
        useMaterial3: true,
      ),
      home: MyReport(score: score, response1: response1),
    );
  }
}

class MyReport extends StatefulWidget {
  String response1;
  int score;
  MyReport({super.key, required this.score, required this.response1});

  @override
  State<MyReport> createState() =>
      _MyReportState(score: score, response1: response1);
}

class _MyReportState extends State<MyReport> {
  String response1;
  int score;
  _MyReportState({required this.score, required this.response1});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Here's what we think! 👩🏻‍⚕️"),
        centerTitle: true,
      ),
      body: TextOnly(score: score, response1: response1),
    );
  }
}

// ------------------------------ Text Only ------------------------------

class TextOnly extends StatefulWidget {
  String response1;
  int score;

  TextOnly({super.key, required this.score, required this.response1});

  @override
  State<TextOnly> createState() =>
      _TextOnlyState(score: score, response1: response1);
}

class _TextOnlyState extends State<TextOnly> {
  bool loading = true;
  int score;
  String response1 = "error";
  List<dynamic> responses = [];
  _TextOnlyState({required this.score, required this.response1});

  @override
  void initState() {
    super.initState();
    setState(() {
      responses = [
        Text(
          'Your EPDS Score is ${score}',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 26),
        ),
        // Text(
        //   'What is EPDS',
        //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        // ),
        Text(response1),
        // Text(
        //   'Symptoms',
        //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        // ),
        // Text(response2),
        // Text(
        //   'Precautions',
        //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        // ),
        // Text(response3),
        // Text(
        //   'Doctor Consultancy',
        //   style: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
        // ),
        // Text(response4),
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: 1,
            padding: const EdgeInsets.only(bottom: 20),
            itemBuilder: (context, index) {
              return ListTile(
                isThreeLine: true,
                leading: CircleAvatar(
                  child: Text("F"),
                ),
                title: Text("Fimbry"),
                subtitle: Column(
                  children: [
                    Text(
                      'Your EPDS Score is ${score}',
                      style:
                          TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
                    ),
                    Text(response1),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 15),
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
                      'Another Assessment?',
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
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: const Color.fromARGB(255, 218, 242, 206),
            ),
            child: GestureDetector(
                onTap: () => {
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (c) => PPDMain()),
                          (route) => false)
                    },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(Icons.bar_chart),
                    SizedBox(height: 10),
                    Text(
                      'Back Home',
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
    ));
  }
}

// fromText(query: _textController.text)
