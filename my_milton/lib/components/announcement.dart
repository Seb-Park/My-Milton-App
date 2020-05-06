import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../screens/home/home.dart';

Widget announcementPost(DocumentSnapshot document, Color color) {
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
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          document['title'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          document['author'] +
                              " - Posted " +
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
      onPressed: () {},
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
