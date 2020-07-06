import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:my_milton/components/drawer_button.dart';
import 'package:my_milton/screens/navcards/navhub_cards.dart';
import 'package:my_milton/components/settings_panel.dart';
import 'package:my_milton/screens/auth-screen/auth.dart';
import 'package:my_milton/screens/announcements/announce_feed.dart';
import 'package:my_milton/screens/schedule/schedule_page.dart';
import 'package:my_milton/services/google_oauth.dart';
import 'package:my_milton/services/google_user.dart';
import 'package:my_milton/utilities/primitive_wrapper.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title, this.user}) : super(key: key);
  final String title;
  final String user;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

Future<LoginPage> _signOut() async {
  await FirebaseAuth.instance.signOut();
  signOutGoogle();
//  return new LoginPage();
}

class _MyHomePageState extends State<MyHomePage> {
  var _page = PrimitiveWrapper(0);
  GlobalKey _bottomNavigationKey = GlobalKey();
  Schedule _schedulePage = new Schedule();
  AnnouncementFeed _announcementFeed = new AnnouncementFeed();
  NavhubCards _navhubCards = new NavhubCards();

  Widget drawerButton(String btnText, Color selectedColor, Color selectedFont,
      IconData btnIcn, int btnPage, Function onTapFunction) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: (_page.value != btnPage)
            ? BorderRadius.only(
                topRight: Radius.circular(50), bottomRight: Radius.circular(50))
            : BorderRadius.zero,
        child: FlatButton(
          onPressed: () {
            onTapFunction();
            Navigator.pop(context);
          },
          color: (_page.value == btnPage) ? selectedColor : Colors.white,
//          highlightColor: (_page.value != btnPage) ? Theme.of(context).canvasColor : Colors.white,
          padding: EdgeInsets.only(top: 10, bottom: 10, left: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Icon(
                      btnIcn,
                      color: (_page.value == btnPage)
                          ? selectedFont
                          : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      btnText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: (_page.value == btnPage)
                            ? selectedFont
                            : Colors.black,
                      ),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  void setBottomNavPage(int page) {
    final CurvedNavigationBarState navBarState =
        _bottomNavigationKey.currentState;
    navBarState.setPage(page);
  }

  @override
  Widget build(BuildContext context) {
    print("building home");
    if (!Provider.of<AppUser>(context).email.endsWith("milton.edu")) {
      _signOut();
      return LoginPage(
//        errorMessage: "Please sign in with your milton.edu email",//Error message doesn't work because every time you log out the stream builder detects a change and rebuilds the login page without an error message
          );
    }
    return Scaffold(
      drawer: ClipRRect(
        borderRadius: BorderRadius.zero,
//        borderRadius: BorderRadius.only(
//            topRight: Radius.circular(20.0),
//            bottomRight: Radius.circular(20.0)),
        child: Drawer(
            child: Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              Container(
//              color: Colors.blue,
                decoration: BoxDecoration(
                  border: Border(
                      bottom: BorderSide(width: 1.0, color: Color(0xFFededed))),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 0.0),
                  child: SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Align(
//                            alignment: Alignment.centerLeft,
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              height: 70,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  Provider.of<AppUser>(context)
                                      .photoUrl
                                      .replaceAll('s96-c', 's400-c'),
                                ),
                              ),
                            ),
                            Text(
                              Provider.of<AppUser>(context).username,
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
//                                      color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              Provider.of<AppUser>(context).email,
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
              DrawerButton(
                btnText: "Profile",
                selectedColor: Color(0xFFfff3d1),
                selectedFontColor: Colors.orange,
                btnIcn: Icons.account_circle,
                btnPage: 4,
                onTap: () {
                  setState(() {
                    _page.value = 4;
                    setBottomNavPage(_page.value);
                  });
                },
                pageValue: _page,
              ),
              DrawerButton(
                btnText: "Home",
                selectedColor: Color(0xFFb0e2ff),
                selectedFontColor: Colors.blue,
                btnIcn: Icons.home,
                btnPage: 0,
                onTap: () {
                  setState(() {
                    _page.value = 0;
                    setBottomNavPage(_page.value);
                  });
                },
                pageValue: _page,
              ),
              DrawerButton(
                btnText: "Announcements",
                selectedColor: Color(0xFFffd1d1),
                selectedFontColor: Colors.red,
                btnIcn: Icons.chat_bubble_outline,
                btnPage: 1,
                onTap: () {
                  setState(() {
                    _page.value = 1;
                    setBottomNavPage(_page.value);
                  });
                },
                pageValue: _page,
              ),
              DrawerButton(
                btnText: "Hub",
                selectedColor: Color(0xFFb8ffd1),
                selectedFontColor: Colors.green,
                btnIcn: Icons.add_box,
                btnPage: 2,
                onTap: () {
                  setState(() {
                    _page.value = 2;
                    setBottomNavPage(_page.value);
                  });
                },
                pageValue: _page,
              ),
              DrawerButton(
                btnText: "Logout",
                selectedColor: Color(0xFFb8ffd1),
                selectedFontColor: Colors.green,
                btnIcn: Icons.exit_to_app,
                btnPage: 10,
                onTap: () {
                  _signOut();
                  return new LoginPage(
                    errorMessage: "You have logged out.",
                  );
                },
                pageValue: _page,
              ),
            ],
          ),
        ) // Populate the Drawer in the next step.
            ),
      ),
      appBar: AppBar(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
//            bottom: Radius.circular(15),
              bottom: Radius.circular(0)),
        ),
        backgroundColor: Colors.blue,
        elevation: 1.0,
        centerTitle: true,
        title: Text(widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: 'Quicksand')),
      ),
      body: Center(
          child: _page.value == 0
              ? _schedulePage
              : _page.value == 1
                  ? _announcementFeed
                  : _page.value == 2 ? _navhubCards : showSettings(context)),
      bottomNavigationBar: Container(
          decoration:
//              BoxDecoration(border: Border.all(color: Colors.grey, width: 0.1)),
              BoxDecoration(
                  border:
                      Border(top: BorderSide(color: Colors.blue, width: 15))),
          child: CurvedNavigationBar(
            key: _bottomNavigationKey,
            color: Colors.white,
            backgroundColor: Colors.blue,
            height: 50,
            items: <Widget>[
              Icon(
                Icons.schedule,
                size: 30,
                color: Colors.black,
              ),
              Icon(
                Icons.chat_bubble_outline,
                size: 30,
                color: Colors.black,
              ),
              Icon(Icons.add_box, size: 30, color: Colors.black),
              Icon(Icons.people, size: 30, color: Colors.black),
              Icon(Icons.settings, size: 30, color: Colors.black),
            ],
            onTap: (index) {
              setState(() {
                _page.value = index;
              });
            },
          )),
    );
  }
}
