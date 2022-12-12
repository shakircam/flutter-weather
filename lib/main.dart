import 'package:flutter/material.dart';
import 'package:weather/profile.dart';
import 'package:weather/screen/list_screen.dart';
import 'package:weather/screen/loading_screen.dart';
import 'package:weather/screen/user_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserList(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  TextEditingController locationController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  [
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child:  TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your name',
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),

               Padding(
                padding: EdgeInsets.only(bottom: 8.0),
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your phone',
                  ),
                  controller: phoneController,
                 keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(bottom: 40.0),
              child:ElevatedButton(onPressed: (){
                print('My name is -> ${nameController.text} \n phone number is -> ${phoneController.text}');
                _sendDataToSecondScreen(context);
              },
              child: Text(
                'Submit'
              ),
              ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// get the text in the TextField and start the Second Screen
void _sendDataToSecondScreen(BuildContext context) {
  String name = nameController.text;
  String phone = phoneController.text;

  Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(name: name, phone: phone),
      ));
  }
}
