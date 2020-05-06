import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_milton/components/announcement.dart';
import 'package:my_milton/components/period.dart';
import 'package:my_milton/screens/auth-screen/auth.dart';
import 'package:my_milton/services/google_oauth.dart';
import 'package:my_milton/services/google_user.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final String user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String todayOrYesterday(int today, int dayInQuestion) {
  if (dayInQuestion == today) {
    return "Today";
  } else {
    return "Yesterday";
  }
}

class _MyHomePageState extends State<MyHomePage> {
  int _page = 0;

  Widget showSchedule() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Center(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: 50,
                      child: Text(
                          weekdayFromInt(DateTime.now().weekday) +
                              ", " +
                              monthNameFromInt(DateTime.now().month)
                                  .toString() +
                              " " +
                              DateTime.now().day.toString(),
//                          style: GoogleFonts.quicksand(
//                              textStyle: TextStyle(
//                                  fontSize: 36,
//                                  fontWeight: FontWeight.normal))
                          style: TextStyle(
                              fontFamily: 'Quicksand',
                              fontSize: 36,
                              fontWeight: FontWeight.normal))),
                ),
                period(context, "Precalculus", "Hales", "MA41-C-1", "AMC004",
                    "8:20", "9:10"),
                period(context, "Programming 2/3", "Hales", "MACS23", "AMC004",
                    "9:15", "10:00"),
                period(context, "Recess", " ", " ", " ", "10:00", "10:15"),
                period(context, "Biology", "Lillis", "SCHB-2", "PSC202",
                    "10:15", "11:00"),
                period(context, " - ", "", "", "", "11:05", "11:50"),
                period(context, "Advanced Jazz", "Sinicrope", "ADVJIH-2",
                    "K113", "11:55", "12:40"),
                period(context, " - ", "", "", "", "12:30", "1:15"),
                period(context, " - ", "", "", "", "1:20", "2:05"),
                period(context, "Chinese 4", "Shi", "CH4-1", "WRE310", "2:10",
                    "2:55"),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String weekdayFromInt(int dayNo) {
    switch (dayNo) {
      case 1:
        {
          return "Monday";
        }
        break;

      case 2:
        {
          return "Tuesday";
        }
        break;

      case 3:
        {
          return "Wednesday";
        }

      case 4:
        {
          return "Thursday";
        }

      case 5:
        {
          return "Friday";
        }

      case 6:
        {
          return "Saturday";
        }

      default:
        {
          return "Sunday";
        }
        break;
    }
  }

  String monthNameFromInt(int monthNo) {
    switch (monthNo) {
      case 1:
        {
          return "January";
        }
        break;

      case 2:
        {
          return "February";
        }
        break;

      case 3:
        {
          return "March";
        }
        break;

      case 4:
        {
          return "April";
        }
        break;

      case 5:
        {
          return "May";
        }
        break;

      case 6:
        {
          return "June";
        }
        break;

      case 7:
        {
          return "July";
        }
        break;

      case 8:
        {
          return "August";
        }
        break;

      case 9:
        {
          return "September";
        }
        break;
      case 10:
        {
          return "October";
        }
        break;

      case 11:
        {
          return "November";
        }
        break;

      default:
        {
          return "December";
        }
        break;
    }
  }

  Widget showAnnouncements() {
    var tfhoursAgo = Timestamp.fromDate((new DateTime.now())
        .subtract(new Duration(minutes: Duration.minutesPerDay)));
    return (StreamBuilder(
//              stream: Firestore.instance.collection('announcement_board').snapshots(),
        stream: Firestore.instance
            .collection('announcement_posts')
            .where("time",isGreaterThanOrEqualTo: tfhoursAgo)
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
                        newPost(context);
//                        sendPost("Test Post", "Just testing out stuff.");
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(20.0))),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemExtent: 80.0,
//                itemCount: (snapshot.data.documents.length),
//                  itemCount:
//                  (snapshot.data.documents[0]['announcements'].length),
                  itemCount: (snapshot.data.documents.length),
                  itemBuilder: (context, index) =>
//                      announcementSubPost(
//                      ((snapshot.data.documents[0])['announcements'])[index],
//                      Colors.red),
                      announcementPost(
                          snapshot.data.documents[index], Colors.red),
                ),
              ),
            ],
          );
        }));
  }

  newPost(BuildContext context) {
    TextEditingController titleController = new TextEditingController();
    TextEditingController contentController = new TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5.0))),
            content: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                Container(
//              height: context.size.height/2,
//                height: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("New Post",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      TextFormField(
                        controller: titleController,
                        decoration: InputDecoration(
                          hintText: "Title",
                        ),
                      ),
                      TextFormField(
                          controller: contentController,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          decoration: InputDecoration(
                            hintText: "Message",
                          )),
                      MaterialButton(
                        color: Colors.blue,
                        child:
                            Text("Post", style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          if (titleController.text != null &&
                              titleController.text.length > 0) {
                            sendPost(
                                titleController.text, contentController.text);
                            Navigator.pop(context);
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  Future sendPost(String title, String content) async {
    CollectionReference abCollection =
        Firestore.instance.collection('announcement_posts');
//        Firestore.instance.collection('announcement_board');
//    List<DocumentReference> newBoard =(abCollection.document("todays_announcements")
//    as Map)['announcements'] as List<DocumentReference>;
//    newBoard.add({
//      "subject": title,
//      "details" : content,
//      "poster" : Provider.of<AppUser>(context).username,
//      "date_posted" : (DateTime.now()) as Timestamp,
//    } as DocumentReference);
//    return await abCollection.document("todays_announcements").setData({
//      "announcements": [
//        {
//          "subject": title,
//          "details": content,
//          "poster": Provider.of<AppUser>(context).username,
//          "date_posted": Timestamp.fromDate(DateTime.now()),
//        }
//      ]
//    }, merge: true);
    abCollection.add({
      "title": title,
      "content": content,
      "author": Provider.of<AppUser>(context).username,
      "time": Timestamp.fromDate(DateTime.now()),
    });
  }

  Widget showCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: (GridView.count(
        crossAxisCount: 2,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              child: Icon(Icons.announcement),
              onPressed: () {
                setState(() {
                  _page = 1;
                });
              },
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MaterialButton(
              child: Image(image: AssetImage("assets/images/add.png")),
              onPressed: () {},
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0))),
            ),
          ),
        ],
      )),
    );
  }

  @override
  Widget build(BuildContext context) {
    print("building home");
    return Scaffold(
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            bottomRight: Radius.circular(20.0)),
        child: Drawer(
            child: Column(
          children: <Widget>[
            Container(
              color: Colors.blue,
              child: SizedBox(
                  height: 100,
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      Provider.of<AppUser>(context).username,
//                      style: GoogleFonts.quicksand(
//                          textStyle: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              fontSize: 20,
//                              color: Colors.white)),
                      style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  )),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlineButton(
                onPressed: () {},
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.account_circle),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Profile",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlineButton(
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.home),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Home",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: OutlineButton(
                onPressed: () {
                  signOutGoogle();
//                  Navigator.push(context,
//                      MaterialPageRoute(builder: (context) => LoginPage()));
                },
                padding: EdgeInsets.only(top: 20, bottom: 20, left: 10),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Icon(Icons.exit_to_app),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Logout",
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ],
        ) // Populate the Drawer in the next step.
            ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        backgroundColor: Colors.blue,
        elevation: 1.0,
        centerTitle: true,
        title: Text(widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Quicksand')),
      ),
      body: Center(
          child: _page == 0
              ? showSchedule()
              : _page == 1 ? showAnnouncements() : showCards()),
      bottomNavigationBar: Container(
          decoration:
              BoxDecoration(border: Border.all(color: Colors.grey, width: 0.1)),
          child: CurvedNavigationBar(
            color: Theme.of(context).canvasColor,
            backgroundColor: Colors.blue,
            height: 50,
            items: <Widget>[
              Icon(
                Icons.schedule,
                size: 30,
                color: Colors.orange,
              ),
              Icon(
                Icons.announcement,
                size: 30,
                color: Colors.blue,
              ),
              Icon(Icons.people, size: 30, color: Colors.orange),
              Icon(Icons.settings, size: 30, color: Colors.blue),
            ],
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          )),
    );
  }
}
