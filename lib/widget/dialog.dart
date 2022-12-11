
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserInputDialog extends StatelessWidget {

  TextEditingController _nameTextFieldController = TextEditingController();
  TextEditingController _phoneTextFieldController = TextEditingController();
  TextEditingController _addressTextFieldController = TextEditingController();
  TextEditingController _idTextFieldController = TextEditingController();

  _displayDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('AlertDemo with TextField '),
            content: TextField(
              controller: _nameTextFieldController,
              decoration: InputDecoration(hintText: "Enter Text"),
            ),
            actions: [
              new FlatButton(
                child: new Text('SUBMIT'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
