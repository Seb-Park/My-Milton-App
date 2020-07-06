import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_milton/screens/announcements/components/announcement.dart';

import 'components/new_announcement_dialogue.dart';

class AnnouncementFeed extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var tfhoursAgo = Timestamp.fromDate((new DateTime.now())
        .subtract(new Duration(minutes: Duration.minutesPerDay)));
    return StreamBuilder(
        stream: Firestore.instance
            .collection('announcement_posts')
            .where("time", isGreaterThanOrEqualTo: tfhoursAgo)
            .orderBy("time", descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const CircularProgressIndicator();
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Announcements",
                      style: TextStyle(fontFamily: 'Quicksand', fontSize: 25),
                    ),
                    MaterialButton(
                      color: Colors.white,
                      child: Image(
                        image: AssetImage("assets/images/add.png"),
                        height: 20,
                      ),
                      onPressed: () {
                        showDialog(context: context,builder: (context){
                          return NewPost();
                        });
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: snapshot.data.documents.length > 0
                    ? ListView.builder(
                  itemExtent: 80.0,
                  itemCount: (snapshot.data.documents.length),
                  itemBuilder: (context, index) => AnnouncementPost(
                      document: snapshot.data.documents[index]),
                )
                    : Center(child: Text("No announcements here!\n\n\n")),
              ),
            ],
          );
        });
  }
}
