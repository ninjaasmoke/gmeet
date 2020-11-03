import 'package:flutter/material.dart';
import 'package:gmeet/UI/ui-helper.dart';
import 'package:gmeet/pages/joinPage.dart';
import 'package:gmeet/pages/historyPage.dart';
import 'package:gmeet/pages/mainDrawer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meet',
      theme: ThemeData(
          fontFamily: 'robo',
          accentColor: UIHelper().altRed,
          primarySwatch: Colors.green,
          primaryColor: Colors.white),
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: UIHelper().bgColor,
        drawer: MainDrawer(),
        appBar: AppBar(
          iconTheme: IconThemeData(color: UIHelper().iconGrey),
          centerTitle: true,
          title: Row(
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
          backgroundColor: UIHelper().bgColor,
          bottom: TabBar(
            isScrollable: false,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorColor: UIHelper().altRed,
            labelColor: UIHelper().textColor,
            indicatorWeight: 4,
            tabs: <Widget>[
              Tab(
                // icon: Icon(Icons.phone_android),
                text: 'Meetings',
              ),
              Tab(
                // icon: Icon(Icons.history),
                text: 'History',
              )
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[JoinPage(), HistoryPage()],
        ),
      ),
    );
  }
}
