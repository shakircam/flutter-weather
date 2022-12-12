

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

import '../models/user.dart';
import '../utils/database_helper.dart';

class UserList extends StatefulWidget {
   UserList({Key? key}) : super(key: key);

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  DatabaseHelper databaseHelper = DatabaseHelper();
  late List<User> userList;
  int count = 0;

  @override
  Widget build(BuildContext context) {
    userList = <User>[];
    if (userList == null) {
      userList = <User>[];
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Custom List"),
      ),
      body: ListTileTheme(
        style: ListTileStyle.list,
        iconColor: Colors.red,
        dense: true,
        child: ListView.builder(
            itemCount: userList.length,
            itemBuilder: (context, index) =>
                Card(
                    elevation: 8,
                    margin: const EdgeInsets.fromLTRB(20, 5, 20, 5),
                    child : Row(

                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10,5,40,5),
                          child: CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.blue[500],
                            child: Text(userList[index].id.toString()),
                          ),
                        ),

                        Column(
                          children: [
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(userList[index].phone.toString())
                            ),
                            Container(
                                padding: const EdgeInsets.all(5),
                                child: Text(userList[index].address.toString())
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 5 , 10, 5),
                          child:const Icon(Icons.food_bank),
                        )
                      ],
                    )
                )

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () =>
            _displayDialog(context),
      ),
    );
  }

  //Dialog for input data from user
  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Add User Data '),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(hintText: "Enter Name"),
                  ),
                  TextField(
                    controller: _phoneController,
                    decoration: InputDecoration(hintText: "Enter Phone"),
                  ),
                  TextField(
                    controller: _addressController,
                    decoration: InputDecoration(hintText: "Enter Address"),
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  print("name $_nameController");
                  print("_phone $_phoneController");
                  print("addrress $_addressController");
                  var name = _nameController.text.toString();
                  var phone = _phoneController.text.toString();
                  var address = _addressController.text.toString();
                  var user = User( name, phone,address);
                  insertUserData(user);
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<User>> noteListFuture = databaseHelper.getUserList();
      noteListFuture.then((userList) {
        setState(() {
          this.userList = userList;
          count = userList.length;
          print("user data list $userList");
        });
      });
    });
  }

  void insertUserData(User user) async {
    int? result = await databaseHelper.insertData(user);
    print("insert id is $result");
  }
}
