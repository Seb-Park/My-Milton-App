import 'package:flutter/material.dart';
import 'package:my_milton/services/google_user.dart';
import 'package:provider/provider.dart';

Widget showSettings(BuildContext context) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child: Container(
              color: Colors.white,
              height: 100,
              width: 100,
              child: Image.network(
                Provider.of<AppUser>(context)
                    .photoUrl
                    .replaceAll('s96-c', 's400-c'),
              ),
            ),
          ),
        ),
        Text(
          Provider.of<AppUser>(context).username,
          overflow: TextOverflow.fade,
          style: TextStyle(fontFamily: 'Quicksand', fontSize: 20, fontWeight: FontWeight.bold),
        ),
        Text(
          Provider.of<AppUser>(context).email,
          overflow: TextOverflow.fade,
          style: TextStyle(fontSize: 15),
        ),
        Container(
          padding: EdgeInsets.all(8),
          alignment: Alignment.centerLeft,
          child: Text(
            "Notifications",
            style: TextStyle(fontSize: 15),
            textAlign: TextAlign.left,
          ),
        ),
        notificationSetter("Classes"),
        notificationSetter("Free Periods"),
        notificationSetter("Announcements"),
        notificationSetter("Sports"),
        notificationSetter("Attendance"),
      ],
    ),
  );
}

Widget notificationSetter(String type){
  bool hello = true;
  return Padding(
    padding: const EdgeInsets.all(2.0),
    child: Container(
      width: double.infinity,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(type, style: TextStyle(fontFamily: 'Quicksand'),),
              Switch(
                value: hello,
                onChanged: (boolean){},
                activeTrackColor: Colors.orangeAccent,
                activeColor: Colors.white,
                inactiveTrackColor: Color(0xfff0f0f0),
              ),
            ],
          ),
        )
      ),
    ),
  );
}