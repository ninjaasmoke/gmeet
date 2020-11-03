import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gmeet/UI/ui-helper.dart';
import 'package:gmeet/pages/meeting.dart';
import 'package:gmeet/pages/verifyID.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIHelper().bgColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              FlatButton(
                color: UIHelper().buttonBlue,
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                          builder: (BuildContext context) {
                            return MeetingPage(
                              meetingID: "",
                            );
                          },
                          fullscreenDialog: true));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Text(
                    "New Meeting",
                    style: TextStyle(
                        color: UIHelper().bgColor,
                        fontSize: UIHelper().fontSize),
                  ),
                ),
              ),
              SizedBox(
                width: 16.0,
              ),
              OutlineButton(
                borderSide: BorderSide(color: UIHelper().buttonBlue),
                highlightedBorderColor: UIHelper().altRed,
                onPressed: () {
                  Navigator.push(context,
                      CupertinoPageRoute(builder: (BuildContext context) {
                    return VerifyIDPage();
                  }));
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
                  child: Text(
                    "Join with a code",
                    style: TextStyle(
                      color: UIHelper().buttonBlue,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
