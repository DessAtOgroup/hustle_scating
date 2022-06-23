import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/cupertino.dart';

class SetPairs extends StatefulWidget {
  final List<int> pairs;

  SetPairs({required this.pairs, super.key});

  @override
  State<SetPairs> createState() => _SetPairsState();
}

class _SetPairsState extends State<SetPairs> {
  late int pairCount;
  bool firstBuild = true;
  late List<TextEditingController> controllers;

  @override
  Widget build(BuildContext context) {
    if (firstBuild) {
      pairCount = widget.pairs.length;
      controllers = List.generate(
          widget.pairs.length,
          (index) =>
              TextEditingController(text: widget.pairs[index].toString()));
      firstBuild = false;
    } else {
      controllers = List.generate(pairCount, (index) {
        if (index + 1 > controllers.length) {
          return TextEditingController(text: (index + 1).toString());
        } else {
          return controllers[index];
        }
      });
    }
    if (controllers.length != pairCount) {
      controllers = List.generate(
          widget.pairs.length,
          (index) =>
              TextEditingController(text: widget.pairs[index].toString()));
    }

    return CupertinoPageScaffold(
        //  navigationBar: CupertinoNavigationBar(middle: Text('Данные о парах')),
        child: Center(
      child: Form(
        autovalidateMode: AutovalidateMode.always,
        onChanged: () {
          Form.of(primaryFocus!.context!)?.save();
        },
        child: Column(
          children: [
            CupertinoListTile(
              title: Text(''),
            ),
            CupertinoListTile(
                leading: CupertinoButton(
                  child: const Icon(CupertinoIcons.minus),
                  onPressed: () => {changeCount(-1)},
                ),
                trailing: CupertinoButton(
                  child: const Icon(CupertinoIcons.plus),
                  onPressed: () => {changeCount(1)},
                ),
                title: Text('Количество пар'),
                subtitle: Text(pairCount.toString())),
            CupertinoFormSection.insetGrouped(
              header: const Text('Заполните номера пар'),
              children: List<Widget>.generate(pairCount, (int index) {
                return CupertinoTextFormFieldRow(
                  placeholder: 'Введите номер пары',
                  controller: controllers[index],
                );
              }),
            ),
            CupertinoButton(
                child: Text('Записать и вернуться'),
                onPressed: () {
                  List<int> pairs = List.generate(
                      pairCount, (index) => index + 1); //local pairs!!
                  controllers.asMap().forEach((key, value) {
                    int? i = int.tryParse(value.text);
                    pairs[key] = (i == null) ? key + 1 : i;
                  }); //перенесли введенные значения в lSS

                  Navigator.pop(context, pairs); //local pairs
                }),
            CupertinoButton(
                child: Text('Отменить'),
                onPressed: () {
                  Navigator.pop(context, widget.pairs); //local pairs
                })
          ],
        ),
      ),
    ));
  }

  void changeCount(int changer) {
    setState(() {
      // 2<=pairCount <=9  !
      if (!((pairCount == 2) && (changer == -1) ||
          ((pairCount == 9) && (changer == 1)))) {
        pairCount += changer;
      }
      firstBuild = false;
    });
  }
}
