import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmeet/UI/ui-helper.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(canvasColor: UIHelper().bgColor),
      child: Drawer(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 40.0,
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    "Google ",
                    style: TextStyle(
                        color: UIHelper().textColor,
                        fontFamily: 'psan',
                        fontWeight: FontWeight.bold,
                        fontSize: UIHelper().headingFontSize),
                  ),
                  Text(
                    "Meet",
                    style: TextStyle(
                        color: UIHelper().textColor,
                        fontFamily: 'psan',
                        fontSize: UIHelper().headingFontSize),
                  ),
                ],
              ),
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: Icon(
                Icons.settings,
                color: UIHelper().iconGrey,
              ),
              title: Text(
                "Settings",
                style: TextStyle(color: UIHelper().textColor),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: Icon(
                Icons.feedback,
                color: UIHelper().iconGrey,
              ),
              title: Text(
                "Send feedback",
                style: TextStyle(color: UIHelper().textColor),
              ),
              onTap: () {},
            ),
            ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
              leading: Icon(
                Icons.help_outline,
                color: UIHelper().iconGrey,
              ),
              title: Text(
                "Help",
                style: TextStyle(color: UIHelper().textColor),
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
