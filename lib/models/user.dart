
import 'dart:convert';

final String userTable = 'todo';


class UserFields{
  static final List<String> values = [
    id, name, phone, address
  ];

  static final String id = 'id';
  static final String name = 'name';
  static final String phone = 'phone';
  static final String address = 'address';

}

class User {
   int? id;
   String? name;
   String? phone;
   String? address;

   User({this.id, required this.name, required this.phone, required this.address});

   User.fromJson(dynamic json)  {
    id = json[UserFields.id];
    name = json[UserFields.name];
    phone = json[UserFields.phone];
    address = json[UserFields.address];
  }


   Map<String, Object?> toJson() => {
     UserFields.id: id,
     UserFields.name: name,
     UserFields.phone: phone,
     UserFields.address: address
   };

}