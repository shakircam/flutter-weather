
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../db/user_database.dart';
import '../models/user.dart';

class Card_item extends StatefulWidget {
  const Card_item({Key? key}) : super(key: key);

  @override
  State<Card_item> createState() => _Card_itemState();
}

class _Card_itemState extends State<Card_item> {


  List<User> userList =[];
  int count = 0;

  @override
  void initState() {
    super.initState();
    updateListView();
  }


  void updateListView() async {
    var data = await UserDatabase.instance.readAllUser();
    setState(() {
      userList = data;
    });

  }

  // For input
  final TextEditingController _nameTextFieldController = TextEditingController();
  final TextEditingController _phoneTextFieldController = TextEditingController();
  final TextEditingController _addressTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-Do List"),
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
                    child: Row(

                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 5, 40, 5),
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
                                child: Text(userList[index].name.toString())
                            ),
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
                        InkWell(
                          onTap: (){
                            deleteUser(userList[index].id!);
                            _showToast(context, "${userList[index].name.toString()} deleted");
                            setState(() {
                              updateListView();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: const Icon(Icons.delete),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            _updateDialog(context, userList[index]);
                            _showToast(context, "${userList[index].name.toString()} update");
                            setState(() {
                              updateListView();
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.fromLTRB(0, 5, 10, 5),
                            child: const Icon(Icons.update),
                          ),
                        )
                      ],
                    )
                )

        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () =>
            _displayDialog(context),
      ),
    );
  }

  void _showToast(BuildContext context,String text) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content:  Text(text),
        action: SnackBarAction(label: 'UNDO', onPressed: scaffold.hideCurrentSnackBar),
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
                    controller: _nameTextFieldController,
                    decoration: InputDecoration(hintText: "Enter Name"),
                  ),
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: _phoneTextFieldController,
                    decoration: InputDecoration(hintText: "Enter Phone"),
                  ),
                  TextField(
                    controller: _addressTextFieldController,
                    decoration: InputDecoration(hintText: "Enter Address"),
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  var name = _nameTextFieldController.text.toString();
                  var phone = _phoneTextFieldController.text.toString();
                  var address = _addressTextFieldController.text.toString();
                  var user = User( name: name,phone: phone,address: address);

                  insertUserData(user);
                  setState(() {
                    updateListView();
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  //Dialog for update data from user
  _updateDialog(BuildContext context, User user) async {
    // For update
    final TextEditingController _nameTextFieldUpdate = TextEditingController(text: user.name);
    final TextEditingController _phoneTextFieldUpdate = TextEditingController(text: user.phone);
    final TextEditingController _addressTextFieldUpdate = TextEditingController(text: user.address);

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Update User Data '),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _nameTextFieldUpdate,
                    decoration: InputDecoration(hintText: "Name"),
                  ),
                  TextField(
                    controller: _phoneTextFieldUpdate,
                    decoration: InputDecoration(hintText: "Phone"),
                  ),
                  TextField(
                    controller: _addressTextFieldUpdate,
                    decoration: InputDecoration(hintText: "Address"),
                  ),
                ],
              ),
            ),

            actions: [
              TextButton(
                child: const Text('SUBMIT'),
                onPressed: () {
                  var name = _nameTextFieldUpdate.text.toString();
                  var phone = _phoneTextFieldUpdate.text.toString();
                  var address = _addressTextFieldUpdate.text.toString();
                  var update = User(id: user.id, name: name,phone: phone,address: address);
                  print("update name: $name phone: $phone address: $address");
                  updateUserData(update);
                  setState(() {
                    updateListView();
                  });
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }


  @override
  void dispose() {
    UserDatabase.instance.close();
    super.dispose();
  }

  void updateUserData(User user) async{
    await UserDatabase.instance.update(user);
  }

  void deleteUser(int id) async {
    await UserDatabase.instance.delete(id);
  }

  void insertUserData(User user) async {
     await UserDatabase.instance.insertData(user);
  }

}







