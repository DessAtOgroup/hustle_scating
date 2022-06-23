import 'package:flutter/cupertino.dart';
import 'package:hustle_scating/data/data.dart';

import 'package:hustle_scating/presentation/page_set_pairs.dart';
import 'package:hustle_scating/presentation/page_input_scores.dart';
import 'package:hustle_scating/presentation/page_scores_table.dart';
import 'package:hustle_scating/presentation/page_about.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> _pairsList = [0, 1];
  ScatingCalc _scatingCalc = ScatingCalc.empty([0, 1]);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:
          CupertinoNavigationBar(middle: Text('Калькулятор Скейтинга')),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CupertinoButton(
                onPressed: () {
                  _navigateAndGetPairsData(context);
                },
                child: const Text('Ввести данные о парах'),
              ),
              CupertinoButton(
                onPressed: () {
                  _navigateAndGetScores(
                    context,
                  );
                },
                child: const Text('Ввести судейские оценки'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                        builder: (context) =>
                            PositionTable(positions: _scatingCalc.positions)),
                  );
                },
                child: const Text('Посмотреть таблицу мест'),
              ),
              CupertinoButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => About(),
                      ));
                },
                child: const Text(
                  style: TextStyle(fontSize: 5),
                  'О программе',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _navigateAndGetScores(BuildContext context) async {
    List<ScatingScores> result = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                InputScores(tourneyTable: _scatingCalc.tourneyTable)));

    _scatingCalc = ScatingCalc.input(
        result); //здесь обрабатываем результат и переносим в переменную класса
  }

  Future<void> _navigateAndGetPairsData(BuildContext context) async {
    List<int> newPairsList = await Navigator.push(context,
        CupertinoPageRoute(builder: (context) => SetPairs(pairs: _pairsList)));
    if (_pairsList != newPairsList) {
      _pairsList = newPairsList;
      _scatingCalc = ScatingCalc.empty(_pairsList); //.empty(_pairsList);
    }
  }
}
