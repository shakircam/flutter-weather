
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {

  final String name;
  final String phone;

  // receive data from the FirstScreen as a parameter
  const Profile({Key? key, required this.name, required this.phone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: Center(
        child: Text(
          '$name \n $phone',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
