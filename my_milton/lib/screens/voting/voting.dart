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

  List<String> candidateNames = [
    'Sam',
    'Charlotte',
    'Garvin',
    'Austin',
    'Gracie',
    'Sam',
    'Charlotte',
    'Garvin',
    'Austin',
    'Gracie'
  ];
  List<bool> boolList = [
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false,
    false
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Voting",
            style: TextStyle(fontFamily: 'Quicksand'),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: StreamBuilder(
              stream: Firestore.instance
                  .collection("voting/2020/head_monitors")
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 100,
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(" Select your canidates "),
                        ]),
                    Expanded(
                        child: Center(
                          child: ListView.builder(
                            itemExtent: 100.0,
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) =>
                                candidate(
                                    snapshot.data.documents[index], index),
                          ),
                        )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("VOTE"),
                          onPressed: () {vote(snapshot);},
                          color: Colors.blue,
                          textColor: Colors.white,
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          splashColor: Colors.grey,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 100,
                    ),
                  ],
                );
              }
          ),
        ));
  }

  Widget candidate(DocumentSnapshot doc, int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//          onPressed: () {
//            bool value = !boolList[index];
//            setState(() {
//              boolList[index] = value;
//              if (value) {
//                if (twoAgo != null) {
//                  boolList[twoAgo] = false;
//                }
//                if (oneAgo != null) {
//                  twoAgo = oneAgo;
//                }
//                oneAgo = index;
//              }
//            });
//          },
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                doc['name'],
                style: TextStyle(fontFamily: 'Quicksand', fontSize: 20),
              ),
            ),
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
        ),
      ),
    );
  }

  void vote(AsyncSnapshot<dynamic> snapshot) {
    for (int i = 0; i < boolList.length; i++) {
      if (boolList[i]) {
        _voteFor(snapshot.data.documents[i]);
      }
    }
  }

  void _voteFor(DocumentSnapshot document) {
    Firestore.instance.runTransaction((transaction) async {
      DocumentSnapshot freshSnap = await transaction.get(document.reference);
      await transaction
          .update(freshSnap.reference, {'votes': freshSnap['votes'] + 1});
    });
  }
}
