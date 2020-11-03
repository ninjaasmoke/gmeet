import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:gmeet/UI/ui-helper.dart';

enum CurrentState { loading, ready, error }

class MeetingPage extends StatefulWidget {
  final String meetingID;
  MeetingPage({this.meetingID});
  @override
  _MeetingPageState createState() => _MeetingPageState();
}

class _MeetingPageState extends State<MeetingPage> {
  TextEditingController message = TextEditingController();

  bool videoOn = false, voiceOn = false;

  RegExp meetingIDReg = new RegExp(r'[0-9a-z]{3}-[0-9a-z]{4}-[0-9a-z]{3}');

  CurrentState _currentState = CurrentState.loading;

  String getRandomAlpha() {
    Random randomNum = new Random();
    String _chars = 'abcdefghhijklmnopqrstuvwwxyz0123456789';
    return _chars[randomNum.nextInt(_chars.length)];
  }

  String meetingIDGenerator() {
    String _meetingID = '';
    for (var i = 0; i < 3; i++) {
      _meetingID += getRandomAlpha();
    }
    _meetingID += '-';
    for (var i = 0; i < 4; i++) {
      _meetingID += getRandomAlpha();
    }
    _meetingID += '-';
    for (var i = 0; i < 3; i++) {
      _meetingID += getRandomAlpha();
    }
    return meetingIDReg.hasMatch(_meetingID) && _meetingID.length == 12
        ? _meetingID
        : '';
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0)),
                  backgroundColor: UIHelper().bgColor,
                  contentPadding: EdgeInsets.only(
                      top: 32.0, left: 20.0, right: 20.0, bottom: 20.0),
                  content: Text(
                    'Are you sure you want to exit this meeting?',
                    style: TextStyle(
                        color: UIHelper().textColor,
                        fontFamily: 'osan',
                        fontWeight: FontWeight.bold),
                  ),
                  actions: <Widget>[
                    OutlineButton(
                      highlightedBorderColor: UIHelper().cancelRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      borderSide: BorderSide(color: UIHelper().altRed),
                      onPressed: () => Navigator.of(context).pop(true),
                      child: Text(
                        'Yes',
                        style: TextStyle(color: UIHelper().altRed),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                    FlatButton(
                      highlightColor: UIHelper().cancelRed,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0)),
                      color: UIHelper().altRed,
                      onPressed: () => Navigator.of(context).pop(false),
                      child: Text(
                        'No',
                        style: TextStyle(color: UIHelper().bgColor),
                      ),
                    ),
                    SizedBox(
                      width: 4.0,
                    ),
                  ],
                ))) ??
        false;
  }

  String _meetingID = '';

  Future load() async {
    Timer(Duration(seconds: 3), () {
      setState(() {
        _currentState = CurrentState.ready;
      });
    });
  }

  confirmExit() {
    showDialog(
        context: context,
        builder: (content) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4.0)),
            backgroundColor: UIHelper().bgColor,
            contentPadding: EdgeInsets.only(
                top: 32.0, left: 20.0, right: 20.0, bottom: 20.0),
            content: Text(
              'Are you sure you want to exit this meeting?',
              style: TextStyle(
                  color: UIHelper().textColor,
                  fontFamily: 'osan',
                  fontWeight: FontWeight.bold),
            ),
            actions: <Widget>[
              OutlineButton(
                highlightedBorderColor: UIHelper().cancelRed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                borderSide: BorderSide(color: UIHelper().altRed),
                onPressed: () =>
                    {Navigator.of(context).pop(), Navigator.of(context).pop()},
                child: Text(
                  'Yes',
                  style: TextStyle(color: UIHelper().altRed),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
              FlatButton(
                highlightColor: UIHelper().cancelRed,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.0)),
                color: UIHelper().altRed,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  'No',
                  style: TextStyle(color: UIHelper().bgColor),
                ),
              ),
              SizedBox(
                width: 4.0,
              ),
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    load();
    _meetingID = this.widget.meetingID == null || this.widget.meetingID == ""
        ? meetingIDGenerator()
        : this.widget.meetingID;
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.landscape)
          return Scaffold(
            body: Center(
              child: Text(
                "Will work on landscape mode ☻",
                style: TextStyle(
                    color: UIHelper().iconGrey,
                    fontSize: UIHelper().fontSize,
                    fontFamily: 'psan'),
              ),
            ),
          );
        else
          return _currentState != CurrentState.ready
              ? WillPopScope(
                  onWillPop: () async {
                    return false;
                  },
                  child: loadingScreen(),
                )
              : WillPopScope(
                  onWillPop: _onWillPop,
                  child: Scaffold(
                    backgroundColor: Colors.black,
                    appBar: AppBar(
                      elevation: 0,
                      backgroundColor: Colors.black,
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: UIHelper().iconGrey,
                        ),
                        onPressed: () => {confirmExit()},
                      ),
                      title: FlatButton(
                        highlightColor: UIHelper().iconGrey.withOpacity(.5),
                        onPressed: () {},
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              _meetingID,
                              style: TextStyle(
                                  color: UIHelper().textColor,
                                  fontFamily: 'psan',
                                  fontSize: UIHelper().fontSize + 2),
                            ),
                            Icon(
                              Icons.arrow_right,
                              color: UIHelper().textColor,
                              size: 24.0,
                            )
                          ],
                        ),
                      ),
                    ),
                    body: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overscroll) {
                        overscroll.disallowGlow();
                        return true;
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * .5,
                              // color: Colors.grey[900],
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  SizedBox(),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16.0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        SizedBox(),
                                        CircleAvatar(
                                          backgroundColor: UIHelper().cancelRed,
                                          radius: 28.0,
                                          child: IconButton(
                                            icon: Icon(
                                              Icons.call_end,
                                              color: UIHelper().textColor,
                                              size: 28.0,
                                            ),
                                            onPressed: () => {confirmExit()},
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: !videoOn
                                              ? UIHelper().bgColor
                                              : UIHelper().textColor,
                                          radius: 28.0,
                                          child: IconButton(
                                            icon: Icon(
                                              !videoOn
                                                  ? Icons.videocam_off
                                                  : Icons.videocam,
                                              color: !videoOn
                                                  ? UIHelper().iconGrey
                                                  : UIHelper().bgColor,
                                              size: 28.0,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                videoOn = !videoOn;
                                              });
                                            },
                                          ),
                                        ),
                                        CircleAvatar(
                                          backgroundColor: !voiceOn
                                              ? UIHelper().bgColor
                                              : UIHelper().textColor,
                                          radius: 28.0,
                                          child: IconButton(
                                            icon: Icon(
                                              !voiceOn
                                                  ? Icons.mic_off
                                                  : Icons.mic,
                                              color: !voiceOn
                                                  ? UIHelper().iconGrey
                                                  : UIHelper().bgColor,
                                              size: 28.0,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                voiceOn = !voiceOn;
                                              });
                                            },
                                          ),
                                        ),
                                        SizedBox(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            DefaultTabController(
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .06,
                                    child: AppBar(
                                      backgroundColor:
                                          UIHelper().bgColor.withOpacity(.8),
                                      bottom: TabBar(
                                        isScrollable: false,
                                        indicatorColor: UIHelper().altRed,
                                        tabs: <Widget>[
                                          Tab(
                                            icon: Icon(
                                              Icons.people,
                                              color: UIHelper().iconGrey,
                                            ),
                                          ),
                                          Tab(
                                            icon: Icon(
                                              Icons.message,
                                              color: UIHelper().iconGrey,
                                            ),
                                          ),
                                          Tab(
                                            icon: Icon(
                                              Icons.info,
                                              color: UIHelper().iconGrey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .34,
                                    color: UIHelper().bgColor,
                                    child: TabBarView(
                                      physics: NeverScrollableScrollPhysics(),
                                      children: <Widget>[
                                        getPeopleList(),
                                        messaging(),
                                        info(),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              length: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
      },
    );
  }

  Widget getPeopleList() {
    return Container(
      color: UIHelper().bgColor,
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
              leading: CircleAvatar(
                radius: 14.0,
                backgroundColor: UIHelper().accentColor,
              ),
              title: Text(
                "Name $index",
                style: TextStyle(
                    color: UIHelper().textColor,
                    fontSize: UIHelper().fontSize,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(
                  Icons.more_horiz,
                  color: UIHelper().iconGrey,
                ),
                onPressed: () {},
              ),
            );
          }),
    );
  }

  Widget messaging() {
    return ListView(
      reverse: true,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(color: Colors.black12),
          child: Row(
            children: <Widget>[
              Flexible(
                child: TextField(
                  controller: message,
                  textCapitalization: TextCapitalization.sentences,
                  cursorColor: UIHelper().altRed,
                  style: TextStyle(
                      color: UIHelper().textColor,
                      fontFamily: 'osan',
                      fontSize: UIHelper().fontSize),
                  decoration: InputDecoration(
                    hintText: 'Type your message',
                    hintStyle: TextStyle(
                        color: UIHelper().iconGrey.withOpacity(.7),
                        fontStyle: FontStyle.italic,
                        fontFamily: 'psan'),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(0),
                        borderSide: BorderSide.none),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    Icons.send,
                    color: UIHelper().accentColor,
                  ),
                ),
              )
            ],
          ),
        )
      ],
    );
  }

  Widget info() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          ListTile(
            title: Text(
              _meetingID,
              style: TextStyle(
                  color: UIHelper().altRed,
                  fontSize: UIHelper().headingFontSize + 4,
                  fontFamily: 'psan'),
            ),
            subtitle: Text(
              "Share this meeting ID with your collegues",
              style: TextStyle(
                  color: UIHelper().iconGrey,
                  fontSize: UIHelper().fontSize - 2),
            ),
            trailing: IconButton(
              icon: Icon(Icons.share, color: UIHelper().iconGrey),
              onPressed: () {
                print("Kkuygkyu");
              },
            ),
          ),
          SizedBox(
            height: 24.0,
          ),
          ListTile(
            title: Text(
              "Your meeting is safe",
              style: TextStyle(
                  color: UIHelper().textColor.withOpacity(.9),
                  fontSize: UIHelper().headingFontSize + 4,
                  fontFamily: 'psan'),
            ),
            subtitle: Text(
              "No one can join a meeting unless invited or admitted by the host",
              style: TextStyle(
                  color: UIHelper().iconGrey,
                  fontSize: UIHelper().fontSize - 2),
            ),
          )
        ],
      ),
    );
  }

  Widget loadingScreen() {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50.0),
          height: 200,
          width: MediaQuery.of(context).size.width * .8,
          padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: UIHelper().bgColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                this.widget.meetingID == null || this.widget.meetingID == ""
                    ? "Getting your new meeting ID"
                    : "Joining the meeting",
                style: TextStyle(
                    color: UIHelper().textColor,
                    fontFamily: 'psan',
                    fontSize: UIHelper().fontSize),
              ),
              SizedBox(
                height: 50.0,
              ),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(UIHelper().buttonBlue),
              )
            ],
          ),
        ),
      ),
    );
  }
}
