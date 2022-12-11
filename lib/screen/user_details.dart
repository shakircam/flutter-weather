
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/models/user.dart';

class UserDetails extends StatelessWidget {

  const UserDetails({Key? key, required this.user}) : super(key: key);

// Declare a field that holds the Todo.
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(user.name.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(user.name.toString()),
           Text(user.phone.toString()),
           Text(user.address.toString())
          ],
        ),
      ),
    );
  }
}
