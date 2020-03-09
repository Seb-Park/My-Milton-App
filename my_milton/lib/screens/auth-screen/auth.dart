import 'package:flutter/material.dart';
import 'package:my_milton/services/google_oauth.dart';
import 'package:my_milton/screens/home/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      drawer:,
        body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: [Colors.blue, Colors.cyanAccent],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image(image: AssetImage("assets/images/myMiltonSplash.png")),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: MaterialButton(
                onPressed: () {
                  signInWithGoogle().then((id) {
//                  print(id);
                    return MyHomePage(
                      title: "MyMilton",
                    );
                  });
                },
                splashColor: Colors.cyan,
                color: Colors.white,
//                child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                ),
//              shape: RoundedRectangleBorder(Radius.circular(20.0),),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 8.0, right: 40.0, left: 40, bottom: 8.0),
                  child: Text(
                    "Sign in",
                    style: TextStyle(fontSize: 15, fontFamily: "Quicksand"),
                  ),
                )
//              ),
                ),
          )
        ],
      ),
    ));
  }
}
