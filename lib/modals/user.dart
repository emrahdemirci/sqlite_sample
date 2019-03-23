class User {
  int id;
  String username;
  String password;
  User({this.id,this.username,this.password});

  Map<String,dynamic> toMap(){
    Map<String,dynamic> map = new Map();
    map["username"] =username;
    map["password"] =password;

    return map;
  }

}