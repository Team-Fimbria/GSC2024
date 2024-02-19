import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../submission.dart';
import 'questionaire.dart';
import '../../components/primary_appbar.dart';

class PPD_Form extends StatefulWidget {
  String image, question, opt1, opt2, opt3, opt4;
  int ind;
  bool isLast;
  List<int> answers;
  PPD_Form(
      {Key? key,
      required this.image,
      required this.question,
      required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.isLast,
      required this.ind,
      required this.answers})
      : super(key: key);

  @override
  State<PPD_Form> createState() => _PPD_FormState(
      image: image,
      question: question,
      opt1: opt1,
      opt2: opt2,
      opt3: opt3,
      opt4: opt4,
      isLast: isLast,
      ind: ind,
      answers: answers);
}

enum userType { user, organization }

class _PPD_FormState extends State<PPD_Form> {
  final _formKey = GlobalKey<FormState>();
  int ans = 0;
  String image, question, opt1, opt2, opt3, opt4;
  bool isLast;
  int ind;
  List<int> answers;

  _PPD_FormState(
      {required this.image,
      required this.question,
      required this.opt1,
      required this.opt2,
      required this.opt3,
      required this.opt4,
      required this.isLast,
      required this.ind,
      required this.answers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: PrimaryAppBar(
            page: 'ppd',
          ),
          preferredSize: const Size.fromHeight(90.0),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
                Wrap(
                  children: [Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    key: ValueKey('ans_1'),
                    children: [
                      Text(opt1),
                      Radio<int>(
                        value: ans,
                        groupValue: 0,
                        onChanged: (int? value) {
                          setState(() {
                            ans = 0;
                          });
                        },
                      ),
                    ],
                  ),
              ]),
                SizedBox(width: 5),
                Wrap(
                  children: [Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    key: ValueKey('ans_2'),
                    children: [
                      Text(opt2),
                      Radio<int>(
                        value: ans,
                        groupValue: 1,
                        onChanged: (int? value) {
                          setState(() {
                            ans = 1;
                          });
                        },
                      ),
                    ],
                  ),
              ]),
                SizedBox(width: 5),
                Wrap(
                  children: [Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    key: ValueKey('ans_3'),
                    children: [
                      Text(opt3),
                      Radio<int>(
                        value: ans,
                        groupValue: 2,
                        onChanged: (int? value) {
                          setState(() {
                            ans = 2;
                          });
                        },
                      ),
                    ],
                  ),
              ]),
                SizedBox(width: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  key: ValueKey('ans_4'),
                  children: [
                    Text(opt4),
                    Radio<int>(
                      value: ans,
                      groupValue: 3,
                      onChanged: (int? value) {
                        setState(() {
                          ans = 3;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(width: 5),
                Container(
                  width: 300,
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            setState(() {
                              answers[ind] = ans;
                            });
                            isLast
                                ? Navigator.of(context).push(
                                    MaterialPageRoute(
                                        settings: RouteSettings(
                                            name: "/ppd_submission"),
                                        builder: (context) => Submission(
                                            image: PPD_images[8],
                                            question: questions[8],
                                            opt1: option1[8],
                                            opt2: option2[8],
                                            opt3: option3[8],
                                            opt4: option4[8],
                                            answers: answers)),
                                  )
                                : Navigator.of(context).push(
                                    MaterialPageRoute(
                                        settings: RouteSettings(
                                            name: "/ppd_page${ind}"),
                                        builder: (context) => PPD_Form(
                                              image: PPD_images[ind],
                                              question: questions[ind],
                                              opt1: option1[ind],
                                              opt2: option2[ind],
                                              opt3: option3[ind],
                                              opt4: option4[ind],
                                              isLast: ind == 7 ? true : false,
                                              ind: ind + 1,
                                              answers: answers,
                                            )),
                                  );
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF96E072)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 52, vertical: 5)),
                          ),
                          child: const Text(
                            'NEXT',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                        SizedBox(height: 0),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF96E072)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14.0),
                            )),
                            padding: MaterialStateProperty.all<EdgeInsets>(
                                EdgeInsets.symmetric(
                                    horizontal: 80, vertical: 10)),
                          ),
                          child: const Text(
                            'GO BACK',
                            style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Inter',
                            ),
                          ),
                        ),
                      ]),
                ),
              ],
            ),
          ),
        ));
  }
}
