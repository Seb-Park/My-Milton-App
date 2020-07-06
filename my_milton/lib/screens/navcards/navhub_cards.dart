import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_milton/screens/navpage/navpage.dart';
import 'package:my_milton/services/google_user.dart';
import 'package:provider/provider.dart';

class NavhubCards extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
          stream: Firestore.instance
              .document('users/' + Provider.of<AppUser>(context).id)
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return CircularProgressIndicator();
            return (GridView.count(
                crossAxisCount: 2,
                children: snapshot.data['hub_apps'].reversed
                    .toList()
                    .map<Widget>(
                      (item) => item !=
                      100 //100 is the code for the add more widgets button which is added by default to every user on registry
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      splashColor: Colors.cyan,
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Text(''),
                          ),
                          Center(child: Icon(iconMap[item])),
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15.0, bottom: 15.0),
                              child: Text(
                                pageTitleMap[item],
                                style: TextStyle(
                                    fontFamily: 'Quicksand'),
                              ),
                            ),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                pagesMap[item]));
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.0))),
                    ),
                  )
                      : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MaterialButton(
                      splashColor: Colors.cyan,
                      child: Image(
                          image: AssetImage("assets/images/add.png")),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavHub()));
                      },
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(8.0))),
                    ),
                  ),
                )
                    .toList()));
          }),
    );
  }
}
