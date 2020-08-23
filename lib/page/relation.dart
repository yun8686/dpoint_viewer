import 'package:flutter/material.dart';

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
