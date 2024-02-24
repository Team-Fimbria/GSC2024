import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'cards.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/profile.dart';
import '../../components/primary_appbar.dart';

class Recommendations extends StatefulWidget {
  const Recommendations({super.key});

  @override
  State<Recommendations> createState() => _RecommendationsState();
}

class _RecommendationsState extends State<Recommendations> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 25),
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "RECOMMENDATIONS",
                style: TextStyle(
                  fontFamily: 'Inria',
                  fontSize: 22,
                ),
                textAlign: TextAlign.start,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              child: FutureBuilder(
                  future: FirebaseFirestore.instance.collection('users').get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }

                    return ListView.builder(
                      itemCount: snapshot.data?.docs!.length,
                      itemBuilder: (BuildContext context, int index) {
                        print(
                            "Snapshot Data: ${snapshot.data?.docs[index].data()}");
                        if (snapshot.data?.docs[index].data()['uid'] == uid)
                          return Container();
                        return buildCard(
                          profileImage:
                              snapshot.data?.docs[index].data()['photourl'],
                          username: snapshot.data?.docs[index].data()['name'],
                          followers: 0,
                          // snapshot.data?.docs![index].data()['followers'].length,
                          color: Color.fromARGB(0, 218, 242, 206),
                          borderColor: Color.fromARGB(255, 51, 51, 50),
                          onPressed: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => Profile(
                                      uid: snapshot.data?.docs[index]
                                          .data()['uid'],
                                      collection: 'users')),
                            );
                          },
                        );
                      },
                    );

                    // return CarouselSlider(
                    //     items: (snapshot.data! as dynamic)
                    //         .docs
                    //         .map<Widget>((item) => buildCard(
                    //               profileImage: item['photourl'],
                    //               username: item['name'],
                    //               followers: item['followers'].length,
                    //               color: Color.fromARGB(0, 218, 242, 206),
                    //               borderColor:
                    //                   Color.fromARGB(255, 51, 51, 50),
                    //               onPressed: () {
                    //                 Navigator.of(context).pushReplacement(
                    //                   MaterialPageRoute(
                    //                       builder: (context) => Profile(
                    //                           uid: item['uid'],
                    //                           collection: 'users')),
                    //                 );
                    //               },
                    //             ))
                    //         .toList(),
                    //     options: CarouselOptions(
                    //       aspectRatio: 16 / 9,
                    //       viewportFraction: 0.5,
                    //     ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
