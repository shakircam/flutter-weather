
class User{

   int? _id;
   String? _name;
   String? _phone;
   String? _address;

   User(this._name,this._phone,[this._address]);
   User.withId(this._id,this._name,this._phone,[this._address]);

   int? get id => _id;
   String? get name => _name;
   String? get phone => _phone;
   String? get address => _address;

   set id(int? id){
     _id = id;
   }
   set name(String? name){
     _name = name;
   }
   set phone(String? phone){
     _phone = phone;
   }
   set address(String? address){
     _address = address;
   }

   // Object to map
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['phone'] = _phone;
    map['address'] = _address;
    return map;
  }

  //Map to object
  User.fromMap (Map<String, dynamic> map){
     _id = map['id'];
     _name = map['name'];
     _phone = map['phone'];
     _address = map['address'];
   }

}