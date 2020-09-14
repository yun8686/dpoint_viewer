import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class ExpectationPage extends StatefulWidget {
  @override
  ExpectationState createState() => ExpectationState();
}

class ExpectationState extends State<ExpectationPage> {
  double circle = 1.0;
  double activeValue = 1.1;
  double balanceValue = -0.1;
  double before_activeValue = 0.1;
  double before_balanceValue = 0.2;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Card(
                  elevation: 2,
                  color: Color(0xffFF8900),
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    width: size.width / 2 - 50,
                    height: 106,
                    child: Column(children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: size.width / 2 - 50,
                        ),
                        child: Text(
                          'アクティブ',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: size.width / 2 - 50,
                          ),
                          child: Text(
                            '前日${before_activeValue}%',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, right: 0, left: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Stack(children: <Widget>[
                                Positioned(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: Icon(
                                    activeValue > 0
                                        ? Icons.arrow_upward
                                        : activeValue == 0
                                            ? Icons.arrow_forward
                                            : Icons.arrow_downward,
                                    color: Color(0xffFF8900),
                                    size: 32.0,
                                  ),
                                ),
                              ]),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 0.0, right: 0, left: 8),
                                child: Text(
                                  activeValue > 0
                                      ? "+$activeValue%"
                                      : "$activeValue%",
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ]),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Card(
                  elevation: 2,
                  color: Color(0xff29DE1A),
                  child: Container(
                    margin: const EdgeInsets.all(12.0),
                    width: size.width / 2 - 50,
                    height: 106,
                    child: Column(children: <Widget>[
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: size.width / 2 - 50,
                        ),
                        child: Text(
                          'バランス',
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 6.0, right: 0, left: 0),
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: size.width / 2 - 50,
                          ),
                          child: Text(
                            '前日${before_balanceValue}%',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 4.0, right: 0, left: 0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Stack(children: <Widget>[
                                Positioned(
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 4,
                                  left: 4,
                                  child: Icon(
                                    balanceValue > 0
                                        ? Icons.arrow_upward
                                        : balanceValue == 0
                                            ? Icons.arrow_forward
                                            : Icons.arrow_downward,
                                    color: Color(0xff29DE1A),
                                    size: 32.0,
                                  ),
                                ),
                              ]),
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 0.0, right: 0, left: 8),
                                child: Text(
                                  balanceValue > 0
                                      ? "+$balanceValue%"
                                      : "$balanceValue%",
                                  style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28.0,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ]),
                      ),
                    ]),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Circlegraph(),
            ),
          ],
        ));
  }
}

class Circlegraph extends StatefulWidget {
  @override
  CirclegraphState createState() => CirclegraphState();
}

class CirclegraphState extends State<Circlegraph> {
  Map<String, double> dataMap = new Map();
  List<Color> colorList = [
    Color(0xffFF8900),
    Color(0xff29DE1A),
    Colors.grey,
  ];

  @override
  Widget build(BuildContext context) {
    dataMap.putIfAbsent("アクティブ", () => 10);
    dataMap.putIfAbsent("バランス", () => 3);
    dataMap.putIfAbsent("引き出す", () => 2);
    return PieChart(
      dataMap: dataMap,
      colorList: colorList,
      showChartValuesInPercentage: true,
      chartValueStyle:
          defaultChartValueStyle.copyWith(color: Colors.white, fontSize: 16),
    );
  }
}
