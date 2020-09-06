import 'package:dpoint_viewer/Provider/PriceList.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class VotingPage extends StatefulWidget {
  @override
  VotingPageState createState() => VotingPageState();
}

class VotingPageState extends State<VotingPage> {
  double activePercent = 0.7;
  double balancePercent = 0.3;
  bool pressActiveGood = false;
  bool pressBalanceGood = false;
  int activeCount = 8;
  int balanceCount = 2;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    PriceListProvider.loadLatestPrice();
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new CircularPercentIndicator(
                radius: size.width / 2 - 16,
                lineWidth: 12.0,
                animation: true,
                percent: activePercent,
                center: new Text(
                  "+2.3%",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 28.0,
                    color: Colors.red,
                  ),
                ),
                footer: new Text(
                  "アクティブ",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.orange,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: new CircularPercentIndicator(
                radius: size.width / 2 - 16,
                lineWidth: 13.0,
                animation: true,
                percent: balancePercent,
                center: new Text(
                  "-0.5%",
                  style: new TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.blue,
                  ),
                ),
                footer: new Text(
                  "バランス",
                  style: new TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 17.0),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
        Row(children: <Widget>[
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.thumb_up,
                color: pressActiveGood ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  pressActiveGood = !pressActiveGood;
                  if (pressActiveGood)
                    activeCount = activeCount + 1;
                  else
                    activeCount = activeCount - 1;
                });
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: Icon(
                Icons.thumb_up,
                color: pressBalanceGood ? Colors.blue : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  pressBalanceGood = !pressBalanceGood;
                  if (pressBalanceGood)
                    balanceCount = balanceCount + 1;
                  else
                    balanceCount = balanceCount - 1;
                });
              },
            ),
          ),
        ]),
        Row(children: <Widget>[
          Expanded(
              child: Text(
            '$activeCount人',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
          Expanded(
              child: Text(
            '$balanceCount人',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          )),
        ])
      ],
    );
  }
}
