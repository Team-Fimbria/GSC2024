import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BreastfeedingHistoryScreen extends StatefulWidget {
  final uid;
  const BreastfeedingHistoryScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _BreastfeedingHistoryScreenState createState() => _BreastfeedingHistoryScreenState();
}

class _BreastfeedingHistoryScreenState extends State<BreastfeedingHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    // final User? user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: [
                  0.3,
                  0.75,
                  0.9
                ],
                colors: [
                  Color.fromRGBO(248, 187, 208, 1),
                  Color.fromRGBO(252, 172, 199, 1),
                  Color.fromRGBO(240, 98, 146, 1),
                ]),
          ),
        ),
        title: const Text(
          'Breastfeeding History',
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('breastfeeding')
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text('loading....'),
            );
          }
          return
              // Text('OK');
              ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => HistoryCard(
              snap: snapshot.data!.docs[index],
            ),
          );
        },
      ),
    );
  }
}

class HistoryCard extends StatelessWidget {
  final snap;
  const HistoryCard({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('Data');
    print(snap.data());
    return Card(
        color: Colors.pink[50],
        shadowColor: Colors.pink[400],
        margin: EdgeInsets.all(20),
        child: Column(children: [
          Text(
            'Date: ${snap.data()['date']}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Time: ${snap.data()['time']}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Left Side: ${snap.data()['left']}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Right Side: ${snap.data()['right']}',
            style: TextStyle(color: Colors.black),
          ),
        ]));
  }
}
