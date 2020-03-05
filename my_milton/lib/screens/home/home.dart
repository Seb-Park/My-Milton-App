import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_milton/components/period.dart';

class MyMiltonHome extends StatelessWidget {
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
      home: MyHomePage(title: 'MyMilton'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
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
                      child: Text("Monday, March 2",
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

  Widget announcementPost(
      String title, String post, String time, String author, Color color) {
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
                    Container(
                        height: 60,
                        width: 60,
                        child: Card(
                          color: color,
                          elevation: 0.0,
                          shape: CircleBorder(),
                          child: Center(
                              child: Text(author.substring(0, 1),
                                  style: GoogleFonts.quicksand(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15)))),
                        )),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "$title",
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            "$author - Posted at $time",
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        onPressed: () {},
      ),
    );
  }

  Widget showAnnouncements() {
    return (Column(
      children: <Widget>[
        announcementPost(
            "REMINDER: Late start on Thursday.",
            "School will start at 10:00 on Thursday.",
            "11:38",
            "José Ruiz",
            Colors.lightBlueAccent),
        announcementPost(
            "Chinese Club Today!",
            "Chinese Club will be meeting at 3:00 Today!",
            "11:36",
            "Sebastian Park",
            Colors.redAccent),
        announcementPost("DONUT DAY!", "Donut Day in the Student Center Today!",
            "9:59", "Andre Heard", Colors.pinkAccent),
        announcementPost(
            "Class III Assembly moved to King.",
            "Junior assembly moved to King theatre today.",
            "7:23",
            "Ryan Stone",
            Colors.orange),
        announcementPost(
            "T-Shirt sale in Student Center",
            "This random club will be selling T-Shirts in the Stu today at 4.",
            "7:30 Yesterday",
            "Random Kid",
            Colors.purple),
      ],
    ));
  }

  @override
  Widget build(BuildContext context) {
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
                      "Sebastian Park",
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
      body: Center(child: _page == 0 ? showSchedule() : showAnnouncements()),
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
