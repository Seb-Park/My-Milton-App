import 'package:firebase_auth/firebase_auth.dart';
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

Future<LoginPage> _signOut() async {
  await FirebaseAuth.instance.signOut();
  signOutGoogle();
  return new LoginPage();
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
  GlobalKey _bottomNavigationKey = GlobalKey();

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
                child: snapshot.data.documents.length > 0
                    ? ListView.builder(
                        itemExtent: 80.0,
//                itemCount: (snapshot.data.documents.length),
//                  itemCount:
//                  (snapshot.data.documents[0]['announcements'].length),
                        itemCount: (snapshot.data.documents.length),
                        itemBuilder: (context, index) =>
//                      announcementSubPost(
//                      ((snapshot.data.documents[0])['announcements'])[index],
//                      Colors.red),
                            announcementPost(snapshot.data.documents[index],
                                Colors.red, context),
                      )
                    : Center(child: Text("No announcements here!\n\n\n")),
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
                  height: MediaQuery.of(context).size.height / 2,
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
                        elevation: 0,
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
                  setBottomNavPage(_page);
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

  Widget drawerButton(String btnText, Color selectedColor, Color selectedFont,
      IconData btnIcn, int btnPage, Function onTapFunction) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: (_page != btnPage)
            ? BorderRadius.only(
                topRight: Radius.circular(50), bottomRight: Radius.circular(50))
            : BorderRadius.zero,
        child: FlatButton(
          onPressed: () {
            onTapFunction();
            Navigator.pop(context);
          },
          color: (_page == btnPage) ? selectedColor : Colors.white,
//          highlightColor: (_page != btnPage) ? Theme.of(context).canvasColor : Colors.white,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Icon(
                      btnIcn,
                      color: (_page == btnPage) ? selectedFont : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      btnText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: (_page == btnPage) ? selectedFont : Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void setBottomNavPage(int page){
    final CurvedNavigationBarState navBarState =
        _bottomNavigationKey.currentState;
    navBarState.setPage(page);
  }

  @override
  Widget build(BuildContext context) {
    print("building home");
    return Scaffold(
      drawer: ClipRRect(
        borderRadius: BorderRadius.zero,
//        borderRadius: BorderRadius.only(
//            topRight: Radius.circular(20.0),
//            bottomRight: Radius.circular(20.0)),
        child: Drawer(
            child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
//              color: Colors.blue,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Color(0xFFededed))),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Align(
//                            alignment: Alignment.centerLeft,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  Provider.of<AppUser>(context).photoUrl,
                                ),
                              ),
                            ),
                            Text(
                              Provider.of<AppUser>(context).username,
//                      style: GoogleFonts.quicksand(
//                          textStyle: TextStyle(
//                              fontWeight: FontWeight.bold,
//                              fontSize: 20,
//                              color: Colors.white)),
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
//                                      color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              Provider.of<AppUser>(context).email,
                              style: TextStyle(
//                                      fontFamily: 'Quicksand',
//                                      color: Colors.white,
//                                      fontSize: 15,
                                  fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              drawerButton("Profile", Color(0xFFfff3d1), Colors.orange,
                  Icons.account_circle, 4, () {
                setState(() {
                  _page = 4;
                  setBottomNavPage(_page);
                });
              }),
              drawerButton(
                  "Home", Color(0xFFb0e2ff), Colors.blue, Icons.home, 0, () {
                setState(() {
                  _page = 0;
                  setBottomNavPage(_page);
                });
              }),
              drawerButton("Announcements", Color(0xFFffd1d1), Colors.red,
                  Icons.chat_bubble_outline, 1, () {
                setState(() {
                  _page = 1;
                  setBottomNavPage(_page);
                });
              }),
              drawerButton(
                  "Hub", Color(0xFFb8ffd1), Colors.green, Icons.add_box, 3, () {
                setState(() {
                  _page = 3;
                  setBottomNavPage(_page);
                });
              }),
              drawerButton("Logout", Color(0xFFb8ffd1), Colors.green,
                  Icons.exit_to_app, 10, () {
                _signOut();
              }),
            ],
          ),
        ) // Populate the Drawer in the next step.
            ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
//            bottom: Radius.circular(15),
              bottom: Radius.circular(0)),
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
//              BoxDecoration(border: Border.all(color: Colors.grey, width: 0.1)),
          BoxDecoration(border: Border(top: BorderSide(color: Colors.blue, width: 15))),
          child: CurvedNavigationBar(
//            buttonBackgroundColor: Colors.blue,
//            color: Theme.of(context).canvasColor,
            key: _bottomNavigationKey,
            color: Colors.white,
//            animationDuration: Duration(milliseconds: 400),
//            animationCurve: Curves.decelerate,
            backgroundColor: Colors.blue,
            height: 50,
            items: <Widget>[
              Icon(
                Icons.schedule,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.announcement,
                size: 30,
                color: Colors.black,
              ),
              Icon(Icons.people, size: 30, color: Colors.black),
              Icon(Icons.add_box, size: 30, color: Colors.black),
              Icon(Icons.settings, size: 30, color: Colors.black),
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
