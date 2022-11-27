
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {

  Future<void> getLocation() async {
    Position position =  await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
