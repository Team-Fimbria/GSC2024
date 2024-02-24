import 'dart:async';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gsc2024/feeding_tracker/history/breastfeedingHistory.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

import '../components/general_button.dart';
import '../utils/utils.dart';
import '../services/storage_methods.dart';

class Baby extends StatefulWidget {
  String uid;
  Baby({super.key, required this.uid});
  @override
  State<Baby> createState() => _BabyState();
}

class _BabyState extends State<Baby> {
  final TextEditingController clinicEditingController = TextEditingController(),
      doctorEditingController = TextEditingController(),
      notesEditingController = TextEditingController(),
      dateEditingController = TextEditingController(),
      timeEditingController = TextEditingController();
  bool presImageUploaded = false, reportImageUploaded = false;
  bool enabledField = false;
  late Uint8List reportFile, presFile;
  String? reportImageUrl, presImageUrl;
  String aid = const Uuid().v1();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  selectImage(String type) async {
    type == "prescription"
        ? presFile = await pickImage(ImageSource.gallery)
        : reportFile = await pickImage(ImageSource.gallery);

    String? presUrl, reportUrl;
    type == "prescription"
        ? presUrl = await StorageMethods()
            .uploadImageToStorage('prescription', presFile, false)
        : reportUrl = await StorageMethods()
            .uploadImageToStorage('report', reportFile, false);
    setState(() {
      type == "report" ? reportImageUrl = reportUrl : presImageUrl = presUrl;
      type == "prescription"
          ? presImageUploaded = true
          : reportImageUploaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              alignment: Alignment.center,
              child: Text('Clinic/Hospital Name',
                  style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[300]!, width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: TextField(
              controller: clinicEditingController,
              decoration: InputDecoration(
                  hintText: 'Name of the establishment you got your baby checked at',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontFamily: 'Inria')),
            ),
          ),
          Container(
              alignment: Alignment.center,
              child: Text('Doctor\'s Name',
                  style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
          Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[300]!, width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: TextField(
              controller: doctorEditingController,
              decoration: InputDecoration(
                  hintText: 'Name of the doctor who checked your baby',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontFamily: 'Inria')),
            ),
          ),
          // Row(children: [
            Column(children: [
              Container(
                  alignment: Alignment.center,
                  child: Text('Date',
                      style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink[300]!, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  controller: dateEditingController,
                  decoration: InputDecoration(
                      hintText: 'Date of your Appointment',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontFamily: 'Inria')),
                ),
              ),
            ]),
            Column(children: [
              Container(
                  alignment: Alignment.center,
                  child: Text('Time',
                      style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
              Container(
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.pink[300]!, width: 2),
                    borderRadius: BorderRadius.circular(25)),
                child: TextField(
                  controller: timeEditingController,
                  decoration: InputDecoration(
                      hintText: 'Time of your Appointment',
                      border: InputBorder.none,
                      hintStyle: TextStyle(fontFamily: 'Inria')),
                ),
              ),
            ]),
          // ]),
          Container(
              alignment: Alignment.center,
              child: Text('Prescription',
                  style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
          Center(
            child: GeneralButton(
                onPressed: () {
                  selectImage("prescription");
                },
                child: Text(presImageUploaded ? 'Edit Image' : 'Upload Image',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inria',
                      fontSize: 14,
                    ))),
          ),
          Container(
              alignment: Alignment.center,
              child: Text('Lab Reports',
                  style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
          Center(
            child: GeneralButton(
                onPressed: () {
                  selectImage("report");
                },
                child: Text(reportImageUploaded ? 'Edit Image' : 'Upload Image',
                    style: const TextStyle(
                      color: Colors.white,
                      fontFamily: 'Inria',
                      fontSize: 14,
                    ))),
          ),
          Container(
              alignment: Alignment.center,
              child: Text('Notes',
                  style: TextStyle(fontFamily: 'Inria', fontSize: 22))),
          Container(
            height: 170,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.pink[300]!, width: 2),
                borderRadius: BorderRadius.circular(25)),
            child: TextField(
              controller: notesEditingController,
              decoration: InputDecoration(
                  hintText: 'Got something to jot down?',
                  border: InputBorder.none,
                  hintStyle: TextStyle(fontFamily: 'Inria')),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: CupertinoButton(
              alignment: Alignment.center,
              onPressed: () async {
                await _firestore
                    .collection('users')
                    .doc(widget.uid)
                    .collection('appointmentsBaby')
                    .doc(aid)
                    .set({
                  'date': dateEditingController.text,
                  'time': timeEditingController.text,
                  'clinicName': clinicEditingController.text,
                  'doctorName': doctorEditingController.text,
                  'notes': notesEditingController.text!,
                  'prescription': presImageUrl,
                  'report': reportImageUrl
                }).then((value) {
                  dateEditingController.clear();
                  timeEditingController.clear();
                  clinicEditingController.clear();
                  doctorEditingController.clear();
                  notesEditingController.clear();
                });
              },
              padding: EdgeInsets.symmetric(horizontal: 15),
              color: Colors.pink[300],
              borderRadius: BorderRadius.circular(10),
              child: Text(
                "Save",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            alignment: Alignment.center,
            child: CupertinoButton(
              alignment: Alignment.center,
              child: Text(
                'History',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.pink[300],
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      settings: RouteSettings(name: '\history'),
                      builder: (context) => BreastfeedingHistoryScreen(
                            uid: widget.uid,
                          )),
                );
              },
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    ));
  }
}
