import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewPost extends StatelessWidget {

  TextEditingController titleController = new TextEditingController();
  TextEditingController contentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(5.0))),
      content: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 2,
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
  }

  Future sendPost(String title, String content) async {
    CollectionReference abCollection =
    Firestore.instance.collection('announcement_posts');
    abCollection.add({
      "title": title,
      "content": content,
      "author": (await FirebaseAuth.instance.currentUser()).displayName,
      "time": Timestamp.fromDate(DateTime.now()),
      "photo_url": (await FirebaseAuth.instance.currentUser()).photoUrl
    });
  }
}
