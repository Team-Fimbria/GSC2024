import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DiaperHistoryScreen extends StatefulWidget {
  final uid;
  const DiaperHistoryScreen({Key? key, required this.uid}) : super(key: key);

  @override
  _DiaperHistoryScreenState createState() => _DiaperHistoryScreenState();
}

class _DiaperHistoryScreenState extends State<DiaperHistoryScreen> {
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
          'Diaper History',
        ),
        centerTitle: false,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .collection('diaper')
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
            'Content of Diaper: ${snap.data()['content']}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Color of Content: ${snap.data()['color']}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Consistency of Content: ${snap.data()['consistency']}',
            style: TextStyle(color: Colors.black),
          ),
          Text(
            'Notes: ${snap.data()['notes']}',
            style: TextStyle(color: Colors.black),
          ),
        ]));
  }
}
