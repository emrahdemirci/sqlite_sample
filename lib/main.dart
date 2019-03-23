import 'package:flutter/material.dart';
import 'package:sqlite_sample/database_helper.dart';
import 'package:sqlite_sample/modals/user.dart';

void main() => runApp(MaterialApp(
      home: SaveApp(),
    ));

class SaveApp extends StatefulWidget {
  @override
  _SaveAppState createState() => _SaveAppState();
}

class _SaveAppState extends State<SaveApp> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  TextEditingController controllerUsername, controllerPassword;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  bool _visible = false;

  void initState() {
    controllerPassword = new TextEditingController();
    controllerUsername = new TextEditingController();

    super.initState();
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            ListTile(
              title: TextField(
                controller: controllerUsername,
                decoration: InputDecoration(labelText: 'Username'),
              ),
            ),
            ListTile(
              title: TextField(
                controller: controllerPassword,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
            ),
            RaisedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            RaisedButton(
              onPressed: _registerUser,
              child: Text('Register'),
            ),
            Visibility(visible: _visible, child: CircularProgressIndicator())
          ],
        ),
      ),
    );
  }

  void _login() async {
    setState(() {
      _visible = true;
    });
    await databaseHelper
        .isCorrectUser(controllerUsername.text, controllerPassword.text)
        .then((result) {
      if (result) {
        _showSnackBar('login başarılı');
      } else {
        _showSnackBar('login başarısız');
      }
    });
    setState(() {
      _visible = false;
    });
  }

  void _registerUser() async {
    setState(() {
      _visible = true;
    });
    await databaseHelper
        .saveUser(new User(
            username: controllerUsername.text,
            password: controllerPassword.text))
        .then((result) {
      if (result > 0) {
        _showSnackBar('kayıt başarılı');
      } else {
        _showSnackBar('kayıt başarısız');
      }
    });
    setState(() {
      _visible = false;
    });
  }
}
