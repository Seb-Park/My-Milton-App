import 'package:flutter/material.dart';
import 'package:my_milton/utilities/primitive_wrapper.dart';

class DrawerButton extends StatelessWidget {

  DrawerButton({this.btnText = "", this.selectedColor = Colors.grey, this.selectedFontColor = Colors.blue, this.btnIcn = Icons.extension, this.btnPage = -1, this.onTap, this.pageValue});

  final String btnText;
  final Color selectedColor;
  final Color selectedFontColor;
  final IconData btnIcn;
  final int btnPage;

  @required
  final Function onTap;
  final PrimitiveWrapper pageValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ClipRRect(
        borderRadius: (pageValue.value != btnPage)
            ? BorderRadius.only(
                topRight: Radius.circular(50), bottomRight: Radius.circular(50))
            : BorderRadius.zero,
        child: FlatButton(
          onPressed: () {
            onTap();
            Navigator.pop(context);
          },
          color: (pageValue.value == btnPage) ? selectedColor : Colors.white,
//          highlightColor: (pageValue.value != btnPage) ? Theme.of(context).canvasColor : Colors.white,
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
                      color: (pageValue.value == btnPage)
                          ? selectedFontColor
                          : Colors.black,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      btnText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: (pageValue.value == btnPage)
                            ? selectedFontColor
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
}
