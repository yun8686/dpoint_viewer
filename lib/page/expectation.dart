import 'package:flutter/material.dart';

// import 'package:percent_indicator/percent_indicator.dart';
class ExpectationPage extends StatefulWidget {
  @override
  ExpectationState createState() => ExpectationState();
}

class ExpectationState extends State<ExpectationPage> {
  double circle = 1.0;
  double activeValue = 1.1;
  double balanceValue = -0.1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
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
                height: 100,
                child: Column(children: <Widget>[
                  Text(
                    'アクティブ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, right: 8, left: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(children: <Widget>[
                            Positioned(
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
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
                          Text(
                            activeValue > 0
                                ? "+$activeValue%"
                                : "$activeValue%",
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                              color: Colors.white,
                            ),
                          ),
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
                height: 100,
                child: Column(children: <Widget>[
                  Text(
                    'バランス',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.white),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 12.0, right: 8, left: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Stack(children: <Widget>[
                            Positioned(
                              child: Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 5,
                              left: 5,
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
                          Text(
                            balanceValue > 0
                                ? "+$balanceValue%"
                                : "$balanceValue%",
                            style: new TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.0,
                              color: Colors.white,
                            ),
                          ),
                        ]),
                  ),
                ]),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            // Padding(
            //   padding: activeFlag ? EdgeInsets.all(16.0) : EdgeInsets.all(20.0),
            //   child: new CircularPercentIndicator(
            //     radius:
            //         activeFlag ? (size.width / 2 - 24) : (size.width / 2 - 48),
            //     lineWidth: 12.0,
            //     animation: true,
            //     percent: circle,
            //     center: new Text(
            //       activeValue > 0 ? "+$activeValue%" : "$activeValue%",
            //       style: new TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: activeFlag ? 28.0 : 20.0,
            //         color: Colors.red,
            //       ),
            //     ),
            //     circularStrokeCap: CircularStrokeCap.round,
            //     progressColor: Colors.orange,
            //   ),
            // ),
            // Padding(
            //   padding:
            //       balanceFlag ? EdgeInsets.all(16.0) : EdgeInsets.all(20.0),
            //   child: new CircularPercentIndicator(
            //     radius:
            //         balanceFlag ? (size.width / 2 - 24) : (size.width / 2 - 48),
            //     lineWidth: 13.0,
            //     animation: true,
            //     percent: circle,
            //     center: new Text(
            //       balanceValue > 0 ? "+$balanceValue%" : "$balanceValue%",
            //       style: new TextStyle(
            //         fontWeight: FontWeight.bold,
            //         fontSize: balanceFlag ? 28.0 : 20.0,
            //         color: Colors.blue,
            //       ),
            //     ),
            //     circularStrokeCap: CircularStrokeCap.round,
            //     progressColor: Colors.green,
            //   ),
            // ),
          ],
        ),
        // Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: <
        //     Widget>[
        //   Padding(
        //     padding: EdgeInsets.only(top: 0.0),
        //     child: Text(
        //       "アクティブ",
        //       style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        //     ),
        //   ),
        //   Padding(
        //     padding: EdgeInsets.only(top: 0.0),
        //     child: Text(
        //       "バランス",
        //       style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
        //     ),
        //   ),
        // ]),
      ],
    );
  }
}
