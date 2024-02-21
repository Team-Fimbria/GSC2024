import 'package:flutter/material.dart';
import 'package:gsc2024/pose_estimation/pose_detector_view.dart';
import 'package:gsc2024/teachable_machine/tm_widget.dart';

class Hold_Main extends StatelessWidget {
  // Sample list of image URLs and corresponding text
  final List<Map<String, dynamic>> dataList = [
    {"image": "images/curlWoman.jpg", "text": "Curl"},
    {"image": "images/squatWoman.png", "text": "Squat"},
    {"image": "images/stretchArmWoman.png", "text": "Arm Stretch"},
    {"image": "images/crossToeTouchWoman.png", "text": "Cross Toe Touch"},
    // Add more items as needed
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Excercises for You'),
        ),
        body: GridView.builder(
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
              settings: RouteSettings(name: "/hold"),
              builder: (context) => TeachableWidget()),
        )
      },
      child: Card(
        child: Stack(
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: 150, // Adjust as needed
              height: 150, // Adjust as needed
            ),
            SizedBox(height: 8.0),
            Text(
              text,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}
