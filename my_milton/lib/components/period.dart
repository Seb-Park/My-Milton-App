import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget period(BuildContext context, String className, String teacher, String course, String place,
    String timeStart, String timeEnd) {
  return Card(
    elevation: 1.0, //Change this maybe?
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
                        color: Colors.orange,
                        elevation: 0.0,
                        shape: CircleBorder(),
                        child: Center(
                            child: Text("$timeStart",
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
                          "$className",
                          style: TextStyle(fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left,
                        ),
                        Text(
                          "$teacher - $course",
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
              Container(
//                    width: 200,
                  child: Text(
                    place,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  )),
            ],
          ),
        ),
      ),
      onPressed: () {
        classDetailDialog(
            context, className, teacher, course, place, timeStart, timeEnd);
      },
    ),
  );
}

classDetailDialog(BuildContext context, String className, String teacher,
    String course, String place, String timeStart, String timeEnd) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
//              height: context.size.height/2,
                height: 128,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(className,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    Text('$timeStart - $timeEnd'),
                    Text(teacher),
                    Text(place),
//                      MaterialButton(
//                        height: 20,
//                        onPressed: (){Navigator.pop(context);},
//                        child: Text("Close", style: TextStyle(color: Colors.blue,fontSize: 15.0),
//                        textAlign: TextAlign.center,)
//                      )
                  ],
                ),
              ),
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child: MaterialButton(
//                    onPressed:(){
//                      Navigator.pop(context);
//                    },
//                    child: Container(
////                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
//                      decoration: BoxDecoration(
//                        color:Colors.white,
//                        borderRadius: BorderRadius.only(
//                            bottomLeft: Radius.circular(32.0),
//                            bottomRight: Radius.circular(32.0)),
//                      ),
//                      child:  Text(
//                        "Close",
//                        style: TextStyle(color: Colors.blue,fontSize: 15.0),
//                        textAlign: TextAlign.center,
//                      ),
//                    ),
//                  ),
//                ),
            ],
          ),
        );
      });
}