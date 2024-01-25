import 'package:gsc2024/postpartum_depression/chatbot.dart';
import 'components/question.dart';
import 'package:flutter/material.dart';
import '../components/primary_appbar.dart';

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
        preferredSize: const Size.fromHeight(110.0),
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

            Center(
              child: Container(
                child: Image.asset("images/mother.png"),
                width: 300,
                height: 200,
              ), //Column
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

            SizedBox(height: 0),
            // Container(
            //   margin: EdgeInsets.only(right: 20, top: 20),
            //   alignment: Alignment.topCenter,
            //   child: Text(
            //     "Petition Title ",
            //     style: TextStyle(
            //       fontSize: 15,
            //       fontWeight: FontWeight.bold,
            //     ),
            //   ),
            // ),

            // Container(
            //   width: 300,
            //   child: Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       TextField(
            //           controller: _textEditingController,
            //           onChanged: (value) {
            //             textNote = value;
            //             _isValid.value = value.isNotEmpty;
            //           },
            //           decoration: InputDecoration(
            //             hintText: "Title must be short ",
            //             focusedBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(11),
            //               borderSide: BorderSide(
            //                 color: Colors.black54,
            //                 width: 1.5,
            //               ),
            //             ),
            //             enabledBorder: OutlineInputBorder(
            //               borderRadius: BorderRadius.circular(11),
            //               borderSide: BorderSide(
            //                 color: Colors.black54,
            //                 width: 1.5,
            //               ),
            //             ),
            //           )),
            //     ],
            //   ),
            // ),

            SizedBox(height: 25),
            TextButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: "/ppd_form"),
                    builder: (context) => PPD_Form(
                      image: "images/mother.png",
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
                backgroundColor:
                    MaterialStateProperty.all<Color>(Color(0xFF96E072)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                )),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 80, vertical: 10)),
              ),
              child: const Text(
                'GO BACK',
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Inter',
                ),
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
          ]),
        ),
      ),
    );
  }
}
