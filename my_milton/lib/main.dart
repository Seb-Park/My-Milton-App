import 'package:flutter/material.dart';
import 'package:my_milton/screens/auth-screen/auth.dart';
import 'package:my_milton/screens/home/home.dart';
import 'package:my_milton/screens/wrapper.dart';
import 'package:my_milton/services/google_oauth.dart';

void main() => runApp(MyMilton());

class MyMilton extends StatefulWidget {
  @override
  _MyMilton createState() => _MyMilton();
}

class _MyMilton extends State<MyMilton> {
  @override
  void initState() {
    signInWithGoogle().then((id) {
      print(id);
    }
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Schedule',
      theme: ThemeData(
        canvasColor: const Color(0xfff0f0f0),
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.orangeAccent,
      ),
      darkTheme: ThemeData.dark(),
      home: Wrapper(),
//      home: LoginPage(title: 'MyMilton'),
//      home: MyHomePage(title: 'MyMilton')
    );

  }
}