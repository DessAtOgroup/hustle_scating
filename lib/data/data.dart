import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

class ScatingScores {
  late int pairNumber;
  late List<int> scores; //Места, расставленные судьями
  late List<int> additional,
      additionalSum; //дополнительные таблицы для сравнения результатов
  late int
      countOfPositions; //количество мест всего (может отличаться от количества судей и максимальных значений оценок)
  late final int majorityOfJudges; //большинство судей

  ScatingScores(
      List<String> inScores, final int this.countOfPositions, this.pairNumber) {
    scores =
        List.generate(inScores.length, (index) => int.parse(inScores[index]));

    majorityOfJudges =
        (scores.length / 2 + 1).truncate(); //большинство голосов судей

    additional = List.generate(countOfPositions, (index) => 0);
    additionalSum = List.generate(countOfPositions, (index) => 0);

    for (int i = 1; i <= countOfPositions; i++) {
      for (int j = 0; j < scores.length; j++) {
        if (scores[j] <= i) {
          additional[i - 1] += 1;
          additionalSum[i - 1] += scores[j];
        }
      }
    }
  }

  int compareTo(ScatingScores two) {
    if (countOfPositions != two.countOfPositions) {
      return 0;
    }
//правило 5-6
    for (int i = 0; i < countOfPositions; i++) {
      if (additional[i] != 0 && two.additional[i] != 0) {
        if ((additional[i] > two.additional[i]) &&
            (additional[i] >= majorityOfJudges)) {
          return 1;
        }
        if ((additional[i] < two.additional[i]) &&
            (two.additional[i] >= majorityOfJudges)) {
          return -1;
        }
        if ((additional[i] >= majorityOfJudges) &&
            (two.additional[i] >= majorityOfJudges)) {
          break;
        } // правило 5 ограничивается разбором только до большинства голосов
      }

      // //один из элементов равен нулю - значит для него большинство голосов судей осталось на бОльших местах, значит он точно уже больше, чем другой,у которого на i позиции еще есть судейские оценки.
      // //это условие возможно нужно удалить.
      // if ((one.additional[i] == 0 || two.additional[i] == 0) && (one.additional[i] + two.additional[i] !=0)) {
      //   if (one.additional[i] > two.additional[i]) {
      //     return 'smaller';
      //   }
      //   if (one.additional[i] < two.additional[i]) {
      //     return 1;
      //   }
      // }
    }
    //Правило 7a
    for (int i = 0; i < countOfPositions; i++) {
      if ((additional[i] == two.additional[i]) &&
          additional[i] >= majorityOfJudges) {
        if ((additionalSum[i] > two.additionalSum[i])) {
          return -1;
        }
        if ((additionalSum[i] < two.additionalSum[i])) {
          return 1;
        }
      }
    }

    //Правило 7b
    for (int i = 0; i < countOfPositions; i++) {
      if (additional[i] != 0 && two.additional[i] != 0) {
        if ((additional[i] > two.additional[i])) {
          return 1;
        }
        if ((additional[i] < two.additional[i])) {
          return -1;
        }
      }
    }

    //Правило 8
    scores.sort();
    two.scores.sort();
    if (listEquals(scores, two.scores)) {
      return 0;
    }

    return 0;
  }
}

class ScatingCalc {
  List<ScatingScores> tourneyTable =
      []; //судейские оценки///входящие значения - мап, номерПары:ЕеМестаПоМнениюСудей
  Map<int, int> positions =
      {}; // рассчитанные места по скейтингу НомерПары:ИтоговоеМесто

  String errorMessage = '';

  ScatingCalc();

  ScatingCalc.input(List<ScatingScores> this.tourneyTable) {
    calculatePositions();
  }

  void clear() {
    positions = {};
  }

  void calculatePositions() {
    Map<int, int> positions = {};
    tourneyTable.sort(((a, b) => a.compareTo(b)));
    for (int i = 0; i < tourneyTable.length; i++) {
      positions
          .addEntries(<int, int>{i + 1: tourneyTable[i].pairNumber}.entries);
    }
  }

  /* int _countRepeat(List<String> inList, String inVal) {
    int rez = 0;
    for (var element in inList) {
      if (element == inVal) {
        rez += 1;
      }
    }
    return rez;
  }

  /// находим максимальное значение, количество повторений и первую позицию этого максимального значения в массиве
  ///
  List<int> _getMaxAndCount(List<int> inList) {
    int max = 0;
    int count = 0;
    int pos = 0;
    //for (int element in inList) {
    for (int i = 0; i < inList.length; i++) {
      var element = inList[i];
      if (element > max) {
        max = element;
        count = 1;
        pos = i;
      } else if (element == max) {
        count += 1;
      }
    }

    return [max, count, pos];
  } */
}