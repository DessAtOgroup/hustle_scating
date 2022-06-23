import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hustle_scating/data/data.dart';

class PositionTable extends StatelessWidget {
  final Map<int, double> positions;
  PositionTable({required this.positions, super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> lT = [];
    positions.forEach((key, value) {
      lT.add(ListTile(
          title: Text('Пара $key.'),
          trailing: Text('$value'),
          leading: Text(value.toString())));
    });
    lT.add(CupertinoButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text("закрыть"),
    ));

    return Scaffold(
      body: Center(child: Column(children: lT)),
    );
  }
}
