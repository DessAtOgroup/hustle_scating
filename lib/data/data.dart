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

  ///Конструктор ожидает 3 параметра
  ///
  ///inScores Массив строк, олицетворяющих судейские оценки для текущей пары
  ///
  ///countOfPositions Всего количество пар в соревновании
  ///
  ///pairNumber Номер текущей пары.
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
      return 0; //TODO это не должно быть здесь
    }
//правило 5-6
    for (int i = 0; i < countOfPositions; i++) {
      // if (additional[i] != 0 && two.additional[i] != 0) {
      if ((additional[i] > two.additional[i]) &&
          (additional[i] >= majorityOfJudges)) {
        return -1;
      }
      if ((additional[i] < two.additional[i]) &&
          (two.additional[i] >= majorityOfJudges)) {
        return 1;
      }
      if ((additional[i] >= majorityOfJudges) &&
          (two.additional[i] >= majorityOfJudges)) {
        break;
      } // правило 5 ограничивается разбором только до большинства голосов
      //}

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
          return 1;
        }
        if ((additionalSum[i] < two.additionalSum[i])) {
          return -1;
        }
      }
    }

    //Правило 7b
    for (int i = 0; i < countOfPositions; i++) {
      if (additional[i] != 0 && two.additional[i] != 0) {
        if ((additional[i] > two.additional[i])) {
          return -1;
        }
        if ((additional[i] < two.additional[i])) {
          return 1;
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
  Map<int, double> positions =
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
    int _pairCount = tourneyTable.length;
    List<double> avPoints = List.generate(_pairCount, (index) => 0);
    tourneyTable.sort(((a, b) => a.compareTo(b)));
    for (int i = 0; i < _pairCount; i++) {
      positions.addEntries(<int, double>{
        tourneyTable[i].pairNumber: (i + 1).toDouble()
      }.entries);

      if (i < _pairCount - 1) {
        if (tourneyTable[i].compareTo(tourneyTable[i + 1]) == 0) {
          avPoints[i] = 1;
          avPoints[i + 1] = 1;
        }
      }
    }

    if (!avPoints.contains(1)) {
      //если все отличаются, то миссия завершена.
      return;
    }

    //Правило 8 - усредняем места, при равенстве всего
    int predZnach = 0;
    int sumPos = 0;
    int kolPos = 0;
    int startPosition = 0;
    int endPosition = 0;
    for (int i = 0; i < _pairCount; i++) {
      if (avPoints[i] == 1) {
        if (predZnach == 0) {
          startPosition = i;
          sumPos = (i + 1);
          kolPos = 1;
        }
        if (predZnach == 1) {
          sumPos += (i + 1);
          kolPos += 1;
        }
      }
      if ((avPoints[i] == 0) && (predZnach == 1)) {
        endPosition = i - 1;
        insertTo(avPoints, startPosition, endPosition, sumPos / kolPos);
      }

      if ((i == _pairCount - 1) && (avPoints[i] == 1)) {
        endPosition = i;
        insertTo(avPoints, startPosition, endPosition, sumPos / kolPos);
      }
      predZnach = avPoints[i].toInt();
    }

    for (int i = 0; i < _pairCount; i++) {
      if (avPoints[i] != 0) {
        positions[tourneyTable[i].pairNumber] = avPoints[i];
      }
    }
  }

  void insertTo(List<double> inList, int inStart, int inEnd, double inValue) {
    for (int i = inStart; i <= inEnd; i++) {
      inList[i] = inValue;
    }
  }
}
