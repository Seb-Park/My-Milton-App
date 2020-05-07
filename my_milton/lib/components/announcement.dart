import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/home/home.dart';

Widget announcementPost(
    DocumentSnapshot document, Color color, BuildContext context) {
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
                            child: Text(document['author'].substring(0, 1),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Quicksand'))),
                      )),
                  Container(
//                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width-120),
                          child: Text(
                            document['title'],
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Text(
                          document['author'] +
//                              " - Posted " +
                              " - " +
                              todayOrYesterday(
                                  DateTime.now().weekday,
                                  (document['time'] as Timestamp)
                                      .toDate()
                                      .weekday) +
                              " " +
                              ((document['time'] as Timestamp).toDate())
                                  .hour
                                  .toString() +
                              ":" +
                              ((document['time'] as Timestamp).toDate())
                                  .minute
                                  .toStringAsPrecision(2)
                                  .replaceAll(".", '')
                          //this makes the minutes always have 2 digits and then removes all decimals
                          ,
                          overflow: TextOverflow.ellipsis,
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
      onPressed: () {
        announcementDetails(
            document['title'],
            document['content'],
            todayOrYesterday(DateTime.now().weekday,
                    (document['time'] as Timestamp).toDate().weekday) +
                " " +
                ((document['time'] as Timestamp).toDate()).hour.toString() +
                ":" +
                ((document['time'] as Timestamp).toDate())
                    .minute
                    .toStringAsPrecision(2)
                    .replaceAll(".", ''),
            document['author'],
            context);
      },
    ),
  );
}

Widget announcementPostMock(
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
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Quicksand'))),
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

Widget announcementSubPost(Map post, Color color) {
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
                            child: Text(post['poster'].substring(0, 1),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    fontFamily: 'Quicksand'))),
                      )),
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            post['subject'],
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                          ),
                          Text(
                            post['poster'] +
                                " - Posted " +
                                todayOrYesterday(
                                    DateTime.now().weekday,
                                    (post['date_posted'] as Timestamp)
                                        .toDate()
                                        .weekday) +
                                " " +
                                ((post['date_posted'] as Timestamp).toDate())
                                    .hour
                                    .toString() +
                                ":" +
                                ((post['date_posted'] as Timestamp).toDate())
                                    .minute
                                    .toStringAsPrecision(2)
                                    .replaceAll(".", '')
                            //this makes the minutes always have 2 digits and then removes all decimals
                            ,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
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

announcementDetails(String title, String content, String time, String author,
    BuildContext context) {
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
//                  height: MediaQuery.of(context).size.height / 1.5,
//              height: context.size.height/2,
//                height: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20), textAlign: TextAlign.center,),
                    Padding(
                      padding: const EdgeInsets.only(top:8.0, bottom: 8.0),
                      child: Text(author, style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(time),
                    ),
                    Container(
                      child: Container(
                        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height / 3),
                        width: double.infinity,
                        color: const Color(0xfff0f0f0),
                        child: SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(content),
                              )),
                      ),
                    ),
                    MaterialButton(
                      elevation: 0,
                      color: Colors.blue,
                      child:
                          Text("Close", style: TextStyle(color: Colors.white)),
                      onPressed: () {
                        Navigator.pop(context);
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
