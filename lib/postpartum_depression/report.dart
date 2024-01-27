import 'package:flutter/material.dart';
import 'package:gsc2024/postpartum_depression/main.dart';

const apiKey = "AIzaSyAc8VNOA2zxAJkFsIcAnqdA3gjevglUz8Q";

class Report extends StatelessWidget {
  String response;
  Report({super.key, required this.response});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF96E072)),
        useMaterial3: true,
      ),
      home: MyReport(response: response),
    );
  }
}

class MyReport extends StatefulWidget {
  String response;

  MyReport({
    super.key,
    required this.response,
  });

  @override
  State<MyReport> createState() => _MyReportState(response: response);
}

class _MyReportState extends State<MyReport> {
  String response;
  _MyReportState({required this.response});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Here's what we think! 👩🏻‍⚕️"),
        centerTitle: true,
      ),
      body: TextOnly(response: response),
    );
  }
}

// ------------------------------ Text Only ------------------------------

class TextOnly extends StatefulWidget {
  String response;

  TextOnly({super.key, required this.response});

  @override
  State<TextOnly> createState() => _TextOnlyState(response: response);
}

class _TextOnlyState extends State<TextOnly> {
  bool loading = true;
  String response;

  _TextOnlyState({required this.response});

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
                subtitle: Text(response),
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