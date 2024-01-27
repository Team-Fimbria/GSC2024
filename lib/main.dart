import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/postpartum_depression/main.dart';
import 'package:gsc2024/welcome.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

import 'homepage.dart';
import 'login.dart';
import 'signup.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // await Permission.camera.request();
  // await Permission.microphone.request();
  // await Permission.phone.request();
  // await Permission.activityRecognition.request();
  // await Permission.location.request();
  // await Permission.sms.request();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String uid = '';
  String collection = 'users';

  setCollection() async {
    DocumentSnapshot documentSnapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    if (documentSnapshot.data() == null) {
      collection = 'organizations';
    } else {
      collection = 'users';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fimbria',
          home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                uid = FirebaseAuth.instance.currentUser!.uid;
                setCollection();
                return Home();
              } else {
                //return Splash(duration: 5);
                return WelcomeScreen();
              }
            },
          ),
          routes: {
            'homepage': (context) => const Home(),
            'welcomescreen': (context) => const WelcomeScreen(),
            'login': (context) => const LoginPage(),
            'signup': (context) => const SignupPage(),
            'ppd': (context) => PPDMain(),
          },
        );
  }
}














































