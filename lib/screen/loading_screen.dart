
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/service/location.dart';

class LoadingScreen extends StatefulWidget {
  final String title;
  const LoadingScreen({Key? key,required this.title}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  void getLocation() async {

    Location location = Location();
    await location.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:   Padding(
          padding: EdgeInsets.only(bottom: 40.0),
          child:ElevatedButton(onPressed: (){
            getLocation();
          },
            child: Text(
                'Submit'
            ),
          ),
        ),
      ),
    );
  }
}
