import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/feeding_tracker/bottle.dart';
import 'package:gsc2024/feeding_tracker/breastfeeding.dart';
import 'package:gsc2024/feeding_tracker/pumping.dart';

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
            // centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: "Breastfeeding"),
                Tab(text: "Bottle"),
                Tab(text: "Pump"),
              ],
            ),
            leading: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back)),
          ),
          body: TabBarView(
            children: [
              Breastfeeding(uid: uid),
              Bottle(uid: uid),
              Pump(uid: uid)
            ],
          )),
    );
  }
}
