import 'package:flutter/material.dart';
import 'package:my_milton/screens/schedule/components/period.dart';
import 'package:my_milton/utilities/date_utils.dart';

class Schedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                          DateUtilities.weekdayFromInt(DateTime.now().weekday) +
                              ", " +
                              DateUtilities.monthNameFromInt(DateTime.now().month)
                                  .toString() +
                              " " +
                              DateTime.now().day.toString(),
                          overflow: TextOverflow.ellipsis,
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
}
