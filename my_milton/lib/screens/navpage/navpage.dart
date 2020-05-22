import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_milton/screens/home/home.dart';
import 'package:my_milton/services/google_user.dart';
import 'package:provider/provider.dart';

class NavHub extends StatefulWidget {
  NavHub({Key key, this.isAdding}) : super(key: key);

  final bool isAdding;

  @override
  _NavHubState createState() => _NavHubState();
}

Map<int, IconData> iconMap = {
  0: Icons.home,
  1: Icons.chat_bubble_outline,
  2: Icons.add_box,
  3: Icons.people,
  4: Icons.settings,
  5: Icons.directions_run,
  6: Icons.check_box,
};

Map<int, Widget> pagesMap = {
  0: MyHomePage(title: "MyMilton",),
  1: MyHomePage(title: "MyChats",),
  2: NavHub(),
  3: MyHomePage(title: "MyContacts",),
  4: MyHomePage(title: "MySettings",),
  5: MyHomePage(title: "MySports",),
  6: MyHomePage(title: "MyAttendance",),
};

Map<int, String> pageTitleMap = {
  0: "MyMilton",
  1: "Announcements",
  2: "Hub",
  3: "Contacts",
  4: "Settings",
  5: "Sports Events",
  6: "Attendance",
};

class _NavHubState extends State<NavHub> {


  Future<List> getPins(int pinNo) async {
    DocumentReference userProfile = Firestore.instance
        .document('users/' + Provider.of<AppUser>(context).id);

    userProfile.get().then((profile) {
      var currentPins = profile.data['hub_apps'] as List;
      return currentPins;
    });

    return [];
  }

  Future addPin(int pinNo) async {
    DocumentReference userProfile = Firestore.instance
        .document('users/' + Provider.of<AppUser>(context).id);

    userProfile.get().then((profile) {
      var currentPins = profile.data['hub_apps'] as List;
      if (!currentPins.contains(pinNo)) {
        currentPins.add(pinNo);
      } else {
        currentPins.remove(pinNo);
      }
      print(currentPins.toString());
      userProfile.setData({'hub_apps': currentPins}, merge: true);
    });
  }

  Widget navHubListItem(String title, int hubNo) {
    return Card(
      elevation: 0.0, //Change this maybe?
      child: MaterialButton(
        splashColor: Colors.cyan,
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 0.0),
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(iconMap[hubNo]),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontFamily: 'Quicksand', fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(1.0),
                      child: Text("+",
                          style:
                              TextStyle(fontFamily: 'Quicksand', fontSize: 30)),
                    ),
                    SizedBox(
                      height: 7,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        onPressed: () {
          addPin(hubNo);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Widgets",
          style: TextStyle(fontFamily: 'Quicksand'),
        ),
        centerTitle: true,
      ),
      body: Center(
          child: ListView(children: <Widget>[
        navHubListItem("Voting", 1),
        navHubListItem("Sports Events", 1),
        navHubListItem("Attendance", 6),
        navHubListItem("Atheltics", 5),
        navHubListItem("Course Registration", 1),
        navHubListItem("Announcement Board", 1),
        navHubListItem("Handbook", 1),
        navHubListItem("Transcript", 1),
        navHubListItem("Countdown", 1),
      ])),
    );
  }
}
