import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/postpartum_depression/report.dart';

import '../components/primary_appbar.dart';

class Submission extends StatefulWidget {
  String image, question, opt1, opt2, opt3, opt4;
  List<int> answers;
  Submission(
      {Key? key,
      required this.image,
      required this.question,
      required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.answers})
      : super(key: key);

  @override
  State<Submission> createState() => _SubmissionState(
      image: image,
      question: question,
      opt1: opt1,
      opt2: opt2,
      opt3: opt3,
      opt4: opt4,
      answers: answers);
}

class _SubmissionState extends State<Submission> {
  GlobalKey<FormState> key = GlobalKey();
  String uid = FirebaseAuth.instance.currentUser!.uid;
  String? docID;
  String image, question, opt1, opt2, opt3, opt4;
  List<int> answers;
  int ans = 0, sum = 0;
  String response = "Loading...";

  // Create Gemini Instance
  final gemini = GoogleGemini(
    apiKey: apiKey,
  );

  _SubmissionState(
      {required this.image,
      required this.question,
      required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.answers});
  CollectionReference user = FirebaseFirestore.instance.collection('PPD');
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: PrimaryAppBar(
          page: 'ppd',
        ),
        preferredSize: const Size.fromHeight(110.0),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Text(
                  "Please choose the option that best suits you:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 15,
                  ),
                ),
              ),
              SizedBox(height: 5),
              Center(
                child: Container(
                  child: Image.asset(image),
                  width: 300,
                  height: 200,
                ), //Column
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 0),
                child: Text(
                  question,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Inria',
                    fontSize: 15,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                key: ValueKey('ans3_1'),
                children: [
                  Text(opt1),
                  Radio<num>(
                    value: ans,
                    groupValue: 0,
                    onChanged: (num? value) {
                      setState(() {
                        ans = 0;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(width: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                key: ValueKey('ans3_2'),
                children: [
                  Text(opt2),
                  Radio<num>(
                    value: ans,
                    groupValue: 1,
                    onChanged: (num? value) {
                      setState(() {
                        ans = 1;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(width: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                key: ValueKey('ans3_3'),
                children: [
                  Text(opt3),
                  Radio<num>(
                    value: ans,
                    groupValue: 2,
                    onChanged: (num? value) {
                      setState(() {
                        ans = 2;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(width: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                key: ValueKey('ans3_4'),
                children: [
                  Text(opt4),
                  Radio<num>(
                    value: ans,
                    groupValue: 3,
                    onChanged: (num? value) {
                      setState(() {
                        ans = 3;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(width: 5),

              TextButton(
                onPressed: () async {
                  setState(() {
                    answers[9] = ans;
                    for (var element in answers) {
                      sum += element;
                    }
                  });
                  var userSnap = await FirebaseFirestore.instance
                      .collection('users')
                      .doc(uid)
                      .get();

                  gemini
                      .generateFromText(
                          "What does Edinburgh Postnatal Depression Scale Score of ${sum} tell about me?")
                      .then((value) async {
                    setState(() {
                      response = value.text;
                    });
                    await user.add({
                      'uid': uid,
                      'username': userSnap['name'],
                      'answers': answers,
                      'sum': sum,
                      'date': DateTime.now(),
                      'response': response
                    }).then((DocumentReference doc) => {
                          setState(() {
                            docID = doc.id;
                          })
                        });

                    await _firestore.collection('users').doc(uid).update({
                      'ppd_checkups': FieldValue.arrayUnion([docID])
                    });
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          settings: RouteSettings(name: "/ppd_report"),
                          builder: (context) => Report(response: response)),
                    );
                  }).onError((error, stackTrace) async {
                    setState(() {
                      response = error.toString();
                    });
                    await user.add({
                      'uid': uid,
                      'username': userSnap['name'],
                      'answers': answers,
                      'sum': sum,
                      'date': DateTime.now(),
                      'response': response
                    }).then((DocumentReference doc) => {
                          setState(() {
                            docID = doc.id;
                          })
                        });

                    await _firestore.collection('users').doc(uid).update({
                      'ppd_checkups': FieldValue.arrayUnion([docID])
                    });

                    Navigator.of(context).push(
                      MaterialPageRoute(
                          settings: RouteSettings(name: "/ppd_report"),
                          builder: (context) => Report(response: response)),
                    );
                  });
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF96E072)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.0),
                  )),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 52, vertical: 5)),
                ),
                child: const Text(
                  'SUBMIT',
                  style: TextStyle(
                    color: Colors.black,
                    fontFamily: 'numer',
                  ),
                ),
              ),

              SizedBox(height: 5),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF96E072)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  )),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
                ),
                child: const Text('GO BACK',
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'numer',
                    )),
              ),

              // TextButton(
              //   onPressed: _pickVideo,
              //   child: Text('Select Video'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
