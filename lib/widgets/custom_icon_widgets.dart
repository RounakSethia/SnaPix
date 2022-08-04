import 'package:flutter/material.dart';

//Cammera icon on navigation bar
class CustomIcon extends StatefulWidget {
  CustomIcon({Key? key}) : super(key: key);

  @override
  State<CustomIcon> createState() => _CustomIconState();
}

class _CustomIconState extends State<CustomIcon> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Image.asset('assets/images/camera.png'),
      
    );
  }
}