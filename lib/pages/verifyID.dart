import 'package:flutter/material.dart';
import 'package:gmeet/UI/ui-helper.dart';
import 'package:gmeet/pages/meeting.dart';

class VerifyIDPage extends StatefulWidget {
  @override
  _VerifyIDPageState createState() => _VerifyIDPageState();
}

class _VerifyIDPageState extends State<VerifyIDPage> {
  bool error = false, success = false;
  String meetingID = "";

  RegExp meetingIDReg = new RegExp(r'[0-9a-z]{3}-[0-9a-z]{4}-[0-9a-z]{3}');

  TextEditingController _meetingCode = TextEditingController();

  bool verifyCode(String meetingCode) {
    if (meetingCode.length != 0 && meetingCode.length == 12) {
      print(meetingCode);
      print(meetingIDReg.hasMatch(meetingCode));
      setState(() {
        success = true;
        error = false;
        meetingID = meetingCode;
      });
      return meetingIDReg.hasMatch(meetingCode);
    } else {
      print("Wrong code");
      setState(() {
        success = false;
        error = true;
        meetingID = "";
      });
    }
    return false;
  }

  @override
  void dispose() {
    _meetingCode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: UIHelper().bgColor,
        elevation: 0,
        title: Text(
          "Join with a code",
          style: TextStyle(
              color: UIHelper().textColor,
              fontFamily: 'psan',
              fontSize: UIHelper().headingFontSize),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: UIHelper().iconGrey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              if (success)
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (BuildContext context) {
                  return MeetingPage(
                    meetingID: meetingID,
                  );
                }));
            },
            child: Text(
              'Join',
              style: TextStyle(
                  color: success ? UIHelper().buttonBlue : UIHelper().iconGrey,
                  fontFamily: 'psan',
                  fontSize: UIHelper().fontSize + 2),
            ),
          )
        ],
      ),
      backgroundColor: UIHelper().bgColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20.0, top: 20.0, right: 20.0),
            child: Text(
              'Enter the code provided by the meeting organizer',
              style: TextStyle(
                  color: UIHelper().textColor,
                  fontFamily: 'psan',
                  fontSize: UIHelper().fontSize + 2),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
            margin: EdgeInsets.all(20),
            height: 60.0,
            decoration: BoxDecoration(
                color: UIHelper().bgColor,
                border: Border.all(color: UIHelper().buttonBlue),
                borderRadius: BorderRadius.circular(8.0)),
            child: Theme(
              data: Theme.of(context).copyWith(
                  primaryColor: UIHelper().buttonBlue,
                  accentColor: UIHelper().buttonBlue),
              child: TextField(
                onChanged: (pattern) {
                  verifyCode(pattern);
                },
                onSubmitted: (pattern) {
                  verifyCode(pattern);
                },
                expands: false,
                autofocus: true,
                controller: _meetingCode,
                style: TextStyle(
                    color: UIHelper().textColor,
                    fontFamily: 'psan',
                    fontSize: UIHelper().fontSize + 2),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  hintText: 'Example: abc-defg-hix',
                  hintStyle: TextStyle(
                      color: UIHelper().iconGrey.withOpacity(.7),
                      fontFamily: 'psan'),
                ),
              ),
            ),
          ),
          // Padding(
          //   padding: EdgeInsets.all(20),
          //   child: error
          //       ? Text(
          //           'We have encountered an error with the code. Please try again.',
          //           style: TextStyle(
          //               color: UIHelper().cancelRed.withOpacity(.9),
          //               fontStyle: FontStyle.italic,
          //               fontFamily: 'osan',
          //               fontSize: UIHelper().fontSize),
          //         )
          //       : Container(),
          // )
        ],
      ),
    );
  }
}
