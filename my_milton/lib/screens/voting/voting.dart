import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class VotingPage extends StatefulWidget {
  @override
  _VotingPageState createState() => _VotingPageState();
}

class _VotingPageState extends State<VotingPage> {
  bool oneVal = false;
  bool twoVal = false;
  bool threeVal = false;
  int one = 0;
  int two = 0;
  int three = 0;

  int oneAgo;
  int twoAgo;

  List<String> candidateNames = ['Sam', 'Charlotte', 'Garvin', 'Austin'];
  List<bool> boolList = [false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Vote Now!"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // [Monday] checkbox
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(" Select your canidates "),
                  ]),
              Expanded(
                  child: ListView.builder(
                itemExtent: 100.0,
                itemCount: candidateNames.length,
                itemBuilder: (context, index) =>
                    candidate(candidateNames[index], index),
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("VOTE"),
                    onPressed: _changeText,
                    color: Colors.blue,
                    textColor: Colors.white,
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    splashColor: Colors.grey,
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget candidate(String name, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(name),
        Checkbox(
          value: boolList[index],
          onChanged: (bool value) {
            setState(() {
              boolList[index] = value;
              if (value) {
                if (twoAgo != null) {
                  boolList[twoAgo] = false;
                }
                if (oneAgo != null) {
                  twoAgo = oneAgo;
                }
                oneAgo = index;
              }
            });
          },
        ),
      ],
    );
  }

  void _changeText() {
    setState(() {
      Text("Thanks for Voting!");
      if (oneVal == true) {
        one++;
      }
      if (twoVal == true) {
        two++;
      }
      if (threeVal == true) {
        three++;
      }
      print(one);
      print(two);
      print(three);
    });
  }
}
