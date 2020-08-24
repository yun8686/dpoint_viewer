import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ExpectationPage extends StatefulWidget {
  @override
  ExpectationState createState() => ExpectationState();
}

class ExpectationState extends State<ExpectationPage> {
  double circle = 1.0;
  double activeValue = 1.1;
  double balanceValue = -0.1;
  bool activeFlag = false;
  bool balanceFlag = false;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    activeFlag = activeValue > 0 && (activeValue > balanceValue);
    balanceFlag = balanceValue > 0 && (activeValue < balanceValue);

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: activeFlag ? EdgeInsets.all(16.0) : EdgeInsets.all(20.0),
              child: new CircularPercentIndicator(
                radius:
                    activeFlag ? (size.width / 2 - 24) : (size.width / 2 - 48),
                lineWidth: 12.0,
                animation: true,
                percent: circle,
                center: new Text(
                  activeValue > 0 ? "+$activeValue%" : "$activeValue%",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: activeFlag ? 28.0 : 20.0,
                    color: Colors.red,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.orange,
              ),
            ),
            Padding(
              padding:
                  balanceFlag ? EdgeInsets.all(16.0) : EdgeInsets.all(20.0),
              child: new CircularPercentIndicator(
                radius:
                    balanceFlag ? (size.width / 2 - 24) : (size.width / 2 - 48),
                lineWidth: 13.0,
                animation: true,
                percent: circle,
                center: new Text(
                  balanceValue > 0 ? "+$balanceValue%" : "$balanceValue%",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: balanceFlag ? 28.0 : 20.0,
                    color: Colors.blue,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
            Widget>[
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Text(
              "アクティブ",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 0.0),
            child: Text(
              "バランス",
              style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
            ),
          ),
        ]),
      ],
    );
  }
}
