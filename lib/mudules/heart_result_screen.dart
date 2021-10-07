import 'package:flutter/material.dart';
import 'package:tabibak/shared/styles/icon_broken.dart';

class HeartResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        leading: IconButton(icon: Icon(IconBroken.Arrow___Left_2),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
        body: Center(child: Text('HeartResult Screen')));
  }
}