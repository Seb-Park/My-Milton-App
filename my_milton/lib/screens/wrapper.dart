import 'package:flutter/material.dart';
import 'package:my_milton/services/google_user.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'auth-screen/auth.dart';
import 'home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser>(context);
//    print("!!!" + user.username + " is now the name of the user.");
    print("Reload");
//    return LoginPage();
//    return MyHomePage(title: "MyMilton");
    return (StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if (FirebaseAuth.instance.currentUser() != null&&user.username!=null) {
          return MyHomePage(title: "MyMilton");
//          return LoginPage();
        } else {
          return LoginPage();
        }
      },
    ));
    if (user == null) {
//      print("!!!" + user.username + " is now the name of the user.");
      print("It's the non-usernamed login page");
      return LoginPage();
    } else {
//      return MyHomePage(
//        title: "MyMilton",
//      );
//      return LoginPage();
      print("It's the usernamed login page");
      print("!!!" + user.username + " is now the name of the user.");
//      return LoginPage();
      return MyHomePage(title: "MyMilton");
    }
  }
}
