import 'package:gsc2024/postpartum_depression/chatbot.dart';
import 'package:gsc2024/postpartum_depression/components/fill_column_data.dart';
import 'package:gsc2024/postpartum_depression/graph.dart';
import 'components/question.dart';
import 'package:flutter/material.dart';
import '../components/primary_appbar.dart';
import '../components/general_button.dart';

class PPDMain extends StatelessWidget {
  PPDMain({Key? key}) : super(key: key);
  List<int> answers = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: PrimaryAppBar(
          page: 'ppd',
        ),
        preferredSize: const Size.fromHeight(60.0),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "Let Me Take Care of You 💞",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 22,
                ),
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Container(
                    child: Image.asset("images/mother.png"),
                    width: 200,
                    height: 200,
                  ), //Column
                ),
                SizedBox(width: 5),
                GeneralButton(
                  child: Text(
                    'Start',
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontFamily: 'Inria',
                    ),
                  ),
                  onPressed: () async {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        settings: RouteSettings(name: "/ppd_form"),
                        builder: (context) => PPD_Form(
                          image: "images/laughingWoman.png",
                          question:
                              "I have been able to laugh and see the funny side of things:",
                          opt1: 'As much as I always could',
                          opt2: 'Not quite so much now',
                          opt3: 'Definitely not so much now',
                          opt4: 'Not at all',
                          isLast: false,
                          ind: 0,
                          answers: answers,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ), //Center

            SizedBox(height: 5),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: Text(
                "Start by telling me how you feel... ",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 22,
                ),
              ),
            ),

            // GeneralButton(
            //   child: Text(
            //     'GO BACK',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontFamily: 'Inter',
            //     ),
            //   ),
            //   onPressed: () {
            //     Navigator.pop(context);
            //   },
            // ),
            SizedBox(height: 15),
            SizedBox(
                height: MediaQuery.of(context).size.height, child: ppd_graph()),
            Container(
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: const Color.fromARGB(255, 218, 242, 206),
                ),
                child: GestureDetector(
                    onTap: () => {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: ((context) => ChatBot()),
                              ))
                        },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.bar_chart),
                        SizedBox(height: 10),
                        Text(
                          'Wanna Have a Chat?',
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
            SizedBox(height: 15),

            // Container(
            //     padding: EdgeInsets.all(20),
            //     margin: EdgeInsets.all(20),
            //     decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(50),
            //       color: const Color.fromRGBO(240, 98, 146, 100),
            //     ),
            //     child: GestureDetector(
            //         onTap: () {
            //           // fillColumnData();
            //           Navigator.push(
            //               context,
            //               MaterialPageRoute(
            //                 builder: ((context) => ppd_graph()),
            //               ));
            //         },
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             Icon(Icons.bar_chart),
            //             SizedBox(height: 10),
            //             Text(
            //               'PPD Chart?',
            //               style: TextStyle(
            //                 fontFamily: 'Inria',
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.w700,
            //               ),
            //               textAlign: TextAlign.center,
            //             ),
            //             SizedBox(height: 10),
            //             Icon(Icons.chevron_right)
            //           ],
            //         ))),
          ]),
        ),
      ),
    );
  }
}
