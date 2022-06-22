import 'package:flutter/cupertino.dart';
import 'package:hustle_scating/data/data.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _pairCountController;
  late ScatingCalc _scatingCalc;

  @override
  void initState() {
    super.initState();
    _pairCountController = TextEditingController(text: '2');
  }

  @override
  void dispose() {
    _pairCountController.dispose();
    super.dispose();
  }

  void minusPair() {
    setState(() {
      _pairCountController.text =
          (int.parse(_pairCountController.text) - 1).toString();
    });
  }

  void plusPair() {
    setState(() {
      _pairCountController.text =
          (int.parse(_pairCountController.text) + 1).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
          middle: Text('Введите количество пар в танце')),
      child: ListView(
        children: [
          CupertinoButton(
              child: const Icon(CupertinoIcons.plus), onPressed: plusPair),
          CupertinoTextField(
            controller: _pairCountController,
          ),
          CupertinoButton(
              child: const Icon(CupertinoIcons.minus), onPressed: minusPair),
          CupertinoButton(
            onPressed: () {
              _navigateAndGetScores(
                  context, int.parse(_pairCountController.value.text));
            },
            child: const Text('Ввести судейские места'),
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
        ],
      ),
    );
  }

  Future<void> _navigateAndGetScores(
      BuildContext context, int pairsCount) async {
    List<ScatingScores> result = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => InputData(pairsCount: pairsCount)));

    _scatingCalc = ScatingCalc.input(
        result); //здесь обрабатываем результат и переносим в переменную класса
  }
}

class PositionTable extends StatelessWidget {
  final Map<int, double> positions;
  PositionTable({required this.positions, super.key});

  @override
  Widget build(BuildContext context) {
    List<Text> lT = [];
    positions.forEach((key, value) {
      lT.add(Text('Пара $key. Место $value'));
    });

    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: ListView(
            children: lT,
          ),
        ),
      ),
    );
  }
}

class InputData extends StatelessWidget {
  final int pairsCount;
  InputData({required this.pairsCount, super.key});

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers =
        List.generate(pairsCount, (index) => TextEditingController());

    return CupertinoPageScaffold(
        child: Center(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)?.save();
        },
        child: Column(
          children: [
            CupertinoFormSection.insetGrouped(
              header: const Text('Заполните судейские оценки'),
              children: List<Widget>.generate(pairsCount, (int index) {
                return CupertinoTextFormFieldRow(
                  prefix: Text('Пара номер $index'),
                  placeholder: 'Введите оценки судей',
                  validator: (String? value) {
                    //TODO валидатор должен проверять на одинаковую длину строк и уникальность мест по судьям.
                    /* if (value == null || value.isEmpty) {
                      return 'Необходимо заполнить';
                    } */
                    return null;
                  },
                  controller: controllers[index],
                );
              }),
            ),
            CupertinoButton(
                child: Text('Записать и вернуться'),
                onPressed: () {
                  //здесь собираем scores и возвращаем уже лист ов скорес
                  List<ScatingScores> lSS = [];
                  controllers.asMap().forEach((key, value) {
                    lSS.add(ScatingScores(
                        value.value.text.split(''), pairsCount, key));
                  }); //перенесли введенные значения в lSS

                  Navigator.pop(context, lSS);
                })
          ],
        ),
      ),
    ));
  }
}
