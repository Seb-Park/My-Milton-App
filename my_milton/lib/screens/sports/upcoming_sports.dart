import 'package:flutter/material.dart';

class SportsSchedule extends StatefulWidget{

  @override
  _SportsScheduleState createState() => _SportsScheduleState();
}

class _SportsScheduleState extends State<SportsSchedule>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sports Events", style: TextStyle(fontFamily: 'Quicksand'),),
        centerTitle: true,
      ),
    );
  }

}