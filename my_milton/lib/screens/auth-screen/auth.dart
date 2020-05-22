import 'package:flutter/material.dart';
import 'package:my_milton/services/google_oauth.dart';
import 'package:my_milton/screens/home/home.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.errorMessage}) : super(key: key);
  final String errorMessage;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    print("building the login page");
//    signOutGoogle();
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
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: Image(image: AssetImage("assets/images/myMiltonSplash.png")),
          ),
//          Padding(
//            padding: const EdgeInsets.all(30.0),
//            child: MaterialButton(
//                onPressed: () {
//                  signInWithGoogle().then((id) {
////                  print(id);
//                    return MyHomePage(
//                      title: "MyMilton",
//                    );
//                  });
//                },
//                splashColor: Colors.cyan,
//                color: Colors.white,
////                child: Card(
//                elevation: 1,
//                shape: RoundedRectangleBorder(
//                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
//                ),
////              shape: RoundedRectangleBorder(Radius.circular(20.0),),
//                child: Padding(
//                  padding: const EdgeInsets.only(
//                      top: 8.0, right: 40.0, left: 40, bottom: 8.0),
//                  child: Text(
//                    "Sign in",
//                    style: TextStyle(fontSize: 15, fontFamily: "Quicksand"),
//                  ),
//                )
////              ),
//                ),
//          ),
          SizedBox(
            width: 300,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: MaterialButton(
                  onPressed: () {
                    signInWithGoogle().then((id) {
//                      if(id.username.endsWith("milton.edu")) {
                        print(id.username + " is the newly logged in id!");
                        return MyHomePage(
                          title: "MyMilton",
                        );
//                      }
//                      else{
//
//                        return LoginPage(errorMessage: "Please sign in with your milton.edu email",);
//                      }
                    });
                  },
                  splashColor: Colors.cyan,
                  color: Colors.white,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, right: 20.0, left: 10, bottom: 18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Image(
                          image: AssetImage("assets/images/google-logo.png"),
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30.0),
                          child: Text(
                            "Sign in with Google",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
          widget.errorMessage != null
              ? Text(
                  widget.errorMessage,
                  style: TextStyle(color: Colors.red),
                )
              : Text("")
        ],
      ),
    ));
  }
}
