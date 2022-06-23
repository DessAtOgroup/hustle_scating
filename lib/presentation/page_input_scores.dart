import 'package:flutter/cupertino.dart';
import 'package:hustle_scating/data/data.dart';

class InputScores extends StatelessWidget {
  final List<ScatingScores> tourneyTable;
  InputScores({required this.tourneyTable, super.key});

  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = List.generate(
        tourneyTable.length,
        (index) => TextEditingController(
            text: anotherFold(tourneyTable[index].scores)));

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
              children: List<Widget>.generate(tourneyTable.length, (int index) {
                return CupertinoTextFormFieldRow(
                  prefix: Text('Пара номер ${tourneyTable[index].pairNumber}'),
                  placeholder: 'Введите оценки судей без пробелов',
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
                    lSS.add(ScatingScores(value.value.text.split(''),
                        tourneyTable.length, tourneyTable[key].pairNumber));
                  }); //перенесли введенные значения в lSS

                  Navigator.pop(context, lSS);
                })
          ],
        ),
      ),
    ));
  }

  String anotherFold(List<int> inList) {
    String res = '';
    for (var element in inList) {
      res += element.toString();
    }
    return res;
  }
}
