import 'package:flutter/material.dart';
import 'helpers/Constants.dart';
import 'LoginPage.dart';
import 'HomePage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:screen/screen.dart';

void main() => runApp(MyApp());



class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    debugPrint('test: myapp called');
       return _MyAppState();
  }

}

class _MyAppState extends State<MyApp> {
  String _message = '';

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  _register() {
    debugPrint('test: register called');
    _firebaseMessaging.getToken().then((token) => print(token));
  }

  @override
  void initState() {
    debugPrint('test: initState called');
    // TODO: implement initState
    _register();
    getMessage();
    super.initState();

  }

  final routes = <String, WidgetBuilder>{
    loginPageTag: (context) => LoginPage(),
    homePageTag: (context) => HomePage(),
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: appTitle,
        theme: new ThemeData(
          primaryColor: appDarkGreyColor,
        ),
        home: LoginPage(),
        routes: routes);
  }

  void getMessage() {
    _firebaseMessaging.configure(
        onMessage: (Map<String, dynamic> message) async {
      print('on message $message');
      setState(() => _message = message["notification"]["title"]);
    }, onResume: (Map<String, dynamic> message) async {
      print('on resume $message');
      setState(() => _message = message["notification"]["title"]);
    }, onLaunch: (Map<String, dynamic> message) async {
      print('on launch $message');
      setState(() => _message = message["notification"]["title"]);
    });
  }
}
