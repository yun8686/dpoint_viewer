import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double activePercent = 0.7;
  double balancePercent = 0.3;
  bool pressActiveGood = false;
  bool pressBalanceGood = false;
  int activeCount = 8;
  int balanceCount = 2;

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('ドコモポイント'),
      ),
      body: _selectedIndex == 0
          ? Column(
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
            )
          : RelationPage(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('関連値動'),
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}

class SafeAreaSample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: List.generate(100, (i) => Text('$i 行目')),
      ),
      backgroundColor: Colors.blue,
    );
  }
}

class RelationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(children: [
        _menuItem("外国為替（ドル）", Icon(Icons.settings), -1.0),
        _menuItem("日経平均", Icon(Icons.map), 0.5),
        _menuItem("外国為替（ユーロ）", Icon(Icons.room), -1.1),
        _menuItem("ダウ平均", Icon(Icons.local_shipping), 0.8),
      ]),
    );
  }

  Widget _menuItem(String title, Icon icon, double value) {
    return GestureDetector(
      child: Container(
          padding: EdgeInsets.all(8.0),
          decoration: new BoxDecoration(
              border: new Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey))),
          child: Row(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                child: icon,
              ),
              Text(
                title,
                style: TextStyle(color: Colors.black, fontSize: 18.0),
              ),
              Spacer(),
              Text(
                "$value%",
              ),
            ],
          )),
      onTap: () {
        print("onTap called.");
      },
    );
  }
}
