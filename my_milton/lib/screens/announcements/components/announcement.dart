import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_milton/utilities/date_utils.dart';
import '../../home/home.dart';

class AnnouncementPost extends StatelessWidget{

  AnnouncementPost({this.document});

  final DocumentSnapshot document;

  @override
  Widget build(BuildContext context) {
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
                    document['photo_url'] == null
                        ? Container(
                        height: 60,
                        width: 60,
                        child: Card(
                          color: Colors.orange,
                          elevation: 0.0,
                          shape: CircleBorder(),
                          child: Center(
                              child: Text(document['author'].substring(0, 1),
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                      fontFamily: 'Quicksand'))),
                        ))
                        : Row(
                      children: <Widget>[
                        SizedBox(
                          width: 4.0,
                        ),
                        Container(
                          height: 50,
                          width: 50,
                          decoration: new BoxDecoration(
                              shape: BoxShape.circle,
                              image: new DecorationImage(
                                  fit: BoxFit.cover,
                                  image: new NetworkImage(
                                      document['photo_url']
                                          .toString()
                                          .replaceAll('s96-c', 's400-c')))),
                        ),
                        SizedBox(
                          width: 4.0,
                        )
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width - 120),
                            child: Text(
                              document['title'],
                              overflow: TextOverflow.fade,
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                              softWrap: false,
                            ),
                          ),
                          Text(
                            document['author'] +
                                " - " +
                                DateUtilities.todayOrYesterday(
                                    DateTime.now().weekday,
                                    (document['time'] as Timestamp)
                                        .toDate()
                                        .weekday) +
                                " " +
                                ((document['time'] as Timestamp).toDate())
                                    .hour
                                    .toString() +
                                ":" +
                                (((document['time'] as Timestamp).toDate())
                                    .minute +
                                    100)
                                    .toString()
                                    .substring(1, 3),
                            //this makes the minutes always have 2 digits and then removes all decimals
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
          openPost(context);
        },
      ),
    );
  }

  openPost(BuildContext context){
    return announcementDetails(
        document['title'],
        document['content'],
        DateUtilities.todayOrYesterday(DateTime.now().weekday,
            (document['time'] as Timestamp).toDate().weekday) +
            " " +
            ((document['time'] as Timestamp).toDate()).hour.toString() +
            ":" +
            (((document['time'] as Timestamp).toDate()).minute + 100)
                .toString()
                .substring(1, 3),
        document['author'],
        context);
  }
}

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
                  document['photo_url'] == null
                      ? Container(
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
                          ))
                      : Row(
                          children: <Widget>[
                            SizedBox(
                              width: 4.0,
                            ),
                            Container(
                              height: 50,
                              width: 50,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: new DecorationImage(
                                      fit: BoxFit.cover,
                                      image: new NetworkImage(
                                          document['photo_url']
                                              .toString()
                                              .replaceAll('s96-c', 's400-c')))),
                            ),
                            SizedBox(
                              width: 4.0,
                            )
                          ],
                        ),

//                  child: document['photo_url'] == null
//                          ? Card(
//                              color: color,
//                              elevation: 0.0,
//                              shape: CircleBorder(),
//                              child: Center(
//                                  child: Text(
//                                      document['author'].substring(0, 1),
//                                      style: TextStyle(
//                                          color: Colors.white,
//                                          fontWeight: FontWeight.bold,
//                                          fontSize: 15,
//                                          fontFamily: 'Quicksand'))),
//                            )
//                          : ClipRRect(
//                              borderRadius: BorderRadius.circular(60),
//                              child: Image.network(
//                                document['photo_url'],
//                                fit: BoxFit.contain,
//                              ),
//                            )),
                  Container(
//                    width: double.infinity,
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width - 120),
                          child: Text(
                            document['title'],
                            overflow: TextOverflow.fade,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.left,
                            softWrap: false,
                          ),
                        ),
                        Text(
                          document['author'] +
//                              " - Posted " +
                              " - " +
                              DateUtilities.todayOrYesterday(
                                  DateTime.now().weekday,
                                  (document['time'] as Timestamp)
                                      .toDate()
                                      .weekday) +
                              " " +
                              ((document['time'] as Timestamp).toDate())
                                  .hour
                                  .toString() +
                              ":" +
                              (((document['time'] as Timestamp).toDate())
                                          .minute +
                                      100)
                                  .toString()
                                  .substring(1, 3),
                          //this makes the minutes always have 2 digits and then removes all decimals
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
            DateUtilities.todayOrYesterday(DateTime.now().weekday,
                    (document['time'] as Timestamp).toDate().weekday) +
                " " +
                ((document['time'] as Timestamp).toDate()).hour.toString() +
                ":" +
                (((document['time'] as Timestamp).toDate()).minute + 100)
                    .toString()
                    .substring(1, 3),
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
                                DateUtilities.todayOrYesterday(
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
                    Container(
//                      constraints: BoxConstraints(minHeight:100, maxHeight: 100),
                      child: Text(
                        title,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(author, style: TextStyle(fontSize: 20)),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(time),
                    ),
                    Container(
                      child: Container(
                        constraints: BoxConstraints(
                            maxHeight: MediaQuery.of(context).size.height / 3),
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
