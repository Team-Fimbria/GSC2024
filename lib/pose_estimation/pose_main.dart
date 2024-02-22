import 'package:flutter/material.dart';
import 'package:gsc2024/pose_estimation/pose_detector_view.dart';

class Pose_Main extends StatelessWidget {
  // Sample list of image URLs and corresponding text
  final List<Map<String, dynamic>> dataList = [
    // {"image": "images/curlWoman.jpg", "text": "Curl"},
    {"image": "images/squatWoman.png", "text": "Squat"},
    {"image": "images/stretchArmWoman.png", "text": "Arm Stretch"},
    {"image": "images/jumpingJacksWoman.png", "text": "Jumping Jacks"},
    {"image": "images/crossToeTouchWoman.png", "text": "Cross Toe Touch"},
    {"image": "images/lateralLungeWoman.png", "text": "Lateral Lunge Right"},
    {"image": "images/lateralLungeLeftWoman.png", "text": "Lateral Lunge Left"},
    {"image": "images/reverseLungeWoman.png", "text": "Reverse Lunge Right"},
    {"image": "images/reverseLungeLeftWoman.png", "text": "Reverse Lunge Left"},
    {"image": "images/kneeThrustersWoman.png", "text": "Knee Thrusters Right"},
    {"image": "images/kneeThrustersLeftWoman.png", "text": "Knee Thrusters Left"},
    {"image": "images/birdPoseWoman.png", "text": "Bird Pose Right"},
    {"image": "images/birdPoseLeftWoman.png", "text": "Bird Pose Left"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Excercises for You', style: TextStyle(fontFamily: 'Inria'),),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: GridView.builder(
          itemCount: dataList.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Number of columns in the grid
            crossAxisSpacing: 8.0, // Spacing between columns
            mainAxisSpacing: 8.0, // Spacing between rows
          ),
          itemBuilder: (BuildContext context, int index) {
            // Pass each element of the list to the Tile widget
            return Tile(
              image: dataList[index]['image'],
              text: dataList[index]['text'],
            );
          },
        ),
      ),
    );
  }
}

// Your Tile widget function
class Tile extends StatelessWidget {
  final String image;
  final String text;

  Tile({required this.image, required this.text});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.of(context).push(
          MaterialPageRoute(
              settings: RouteSettings(name: "/pose_est"),
              builder: (context) =>
                  PoseDetectorView(excercise: text.toLowerCase())),
        )
      },
      child: Card(
        child: Stack(
          children: [
            Positioned(
              top: 25,
              child: Image.asset(
                image,
                fit: BoxFit.contain,
                width: 150, // Adjust as needed
                height: 150, // Adjust as needed
              ),
            ),
            SizedBox(height: 8.0),
            Positioned(
              left: 10,
              width: 130,
              child: Text(
                text,
                style: TextStyle(fontSize: 16.0, fontFamily: 'Inria'),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
