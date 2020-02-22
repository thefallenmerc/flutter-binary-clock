import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binary Clock',
      theme: ThemeData(primarySwatch: Colors.red, primaryColor: Colors.black),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  getBinaryArray(num number) {
    var binaryArray = [0, 0, 0, 0];
    if ((number / 8).floor() > 0) {
      binaryArray[0] = 1;
      number = number % 8;
    }
    if ((number / 4).floor() > 0) {
      binaryArray[1] = 1;
      number = number % 4;
    }
    if ((number / 2).floor() > 0) {
      binaryArray[2] = 1;
      number = number % 2;
    }
    if ((number / 1).floor() > 0) {
      binaryArray[3] = 1;
      number = number % 1;
    }
    return binaryArray;
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var time = DateFormat('kk:mm:ss').format(now).split(':');
    Timer timer = Timer(Duration(seconds: 1), () {
      setState(() {});
    });
    var hour = time[0]
        .split('')
        .map((e) => this.getBinaryArray(int.parse(e)))
        .toList();
    var minute = time[1]
        .split('')
        .map((e) => this.getBinaryArray(int.parse(e)))
        .toList();
    var second = time[2]
        .split('')
        .map((e) => this.getBinaryArray(int.parse(e)))
        .toList();

    var binaryClock = [hour, minute, second];

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: makeClock(binaryClock),
            ),
            makeDigitalClock(time)
          ],
        ),
      ),
    );
  }

  List<Widget> makeClock(List binaryClock) {
    return binaryClock.map((segment) {
      return Container(
          padding: EdgeInsets.all(10.0),
          child: Row(children: makeHand(segment)));
    }).toList();
  }

  List<Widget> makeHand(segment) {
    var ret = List<Widget>();
    segment.forEach((digit) {
      ret.add(
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: makeBlock(digit),
        ),
      );
    });
    return ret;
  }

  List<Widget> makeBlock(digit) {
    var blocks = List<Widget>();
    digit.forEach((b) {
      blocks.add(Container(
        width: 40.0,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: b == 1 ? Colors.white : Colors.black),
        height: 40.0,
        margin: EdgeInsets.all(5.0),
      ));
    });
    return blocks;
  }

  Widget makeDigitalClock(List<String> time) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: time
          .asMap()
          .map((index, segment) {
            return MapEntry(
                index,
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 43.0, vertical: 10.0),
                  child: Text(
                    segment,
                    style: TextStyle(color: Colors.white, fontSize: 30.0),
                  ),
                ));
          })
          .values
          .toList(),
    );
  }
}
