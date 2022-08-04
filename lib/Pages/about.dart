import 'package:flutter/material.dart';

class aboutPage extends StatefulWidget {
  aboutPage({Key? key}) : super(key: key);

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 98.0),
          child: Text('About'),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Give people the power to build community and bring the world closer together. \n\nConnect with more people, build influence, and create compelling content that\'s distinctly yours.\n\nShare and grow your brand with our diverse, global community.\n\nJoin us and help inspire creativity around the world.\n\n Made by Rounak & Amrit\n\n Under the guidance of professor Bryan Dixon',
          style: TextStyle(fontSize: 18),
        ),
        
        
      ),
      
    );
  }
}
