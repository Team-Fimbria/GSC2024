import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/feeding_tracker/bottle.dart';
import 'package:gsc2024/feeding_tracker/breastfeeding.dart';
import 'package:gsc2024/feeding_tracker/pumping.dart';

import 'baby.dart';
import 'mother.dart';

class Appointment_Main extends StatelessWidget {
  const Appointment_Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
        useMaterial3: true,
      ),
      home: const Appointment(),
    );
  }
}

class Appointment extends StatefulWidget {
  const Appointment({super.key});

  @override
  State<Appointment> createState() => _AppointmentState();
}

class _AppointmentState extends State<Appointment> {
  String uid = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Track Your Appointments"),
            centerTitle: true,
            bottom: const TabBar(
              tabs: [
                Tab(text: "For You"),
                Tab(text: "For Baby"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Mother(uid: uid),
              Baby(uid: uid)
            ],
          )),
    );
  }
}
