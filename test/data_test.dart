// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hustle_scating/main.dart';
import 'package:hustle_scating/data/data.dart';

void main() {
/*   group('ScatingCalc initializing', () {
    test('creation whithout errors', () {
      ScatingCalc s = ScatingCalc();
      expect(s.errorMessage, '');
    });

    test('simple data without errors', () {
      ScatingCalc s =
          ScatingCalc.input({1: '44444', 2: '33333', 3: '22222', 4: '11111'});
      expect(s.errorMessage, '');
    });

    test('adding data', () {
      ScatingCalc s = ScatingCalc();
      s.add(1, '2');
      s.add(2, '1');
      s.add(4, '3');
      expect(s.errorMessage, '');
      expect(s.scores[2], '1');
    });

    test('adding wrong data', () {
      ScatingCalc s = ScatingCalc();
      s.add(1, '1');
      s.add(2, '1');
      s.add(4, '3');
      expect(s.errorMessage,
          'Судьи проставили оценки неверно. Правило 4 нарушено.');
    });

    test('adding wrong data 2', () {
      ScatingCalc s = ScatingCalc();
      s.add(1, '1');
      s.add(2, '2');
      s.add(4, '3');
      expect(s.errorMessage,
          'Судьи проставили оценки неверно. Правило 4 нарушено.');
    });
  });
 */
  group('ScatingCalc calcing', () {
    ScatingScores ss10 = ScatingScores('33323'.split(''), 6, 10);
    ScatingScores ss16 = ScatingScores('66665'.split(''), 6, 16);
    ScatingScores ss24 = ScatingScores('22541'.split(''), 6, 24);
    ScatingScores ss31 = ScatingScores('44234'.split(''), 6, 31);
    ScatingScores ss45 = ScatingScores('15112'.split(''), 6, 45);
    ScatingScores ss48 = ScatingScores('51456'.split(''), 6, 48);

    ScatingScores ss11 = ScatingScores('15112'.split(''), 6, 11);
    ScatingScores ss21 = ScatingScores('22541'.split(''), 6, 21);
    ScatingScores ss32 = ScatingScores('33323'.split(''), 6, 32);
    ScatingScores ss41 = ScatingScores('44234'.split(''), 6, 41);
    ScatingScores ss51 = ScatingScores('51455'.split(''), 6, 51);
    ScatingScores ss61 = ScatingScores('66666'.split(''), 6, 61);

    test('rule 5-1', () {
      List<ScatingScores> lSC = [ss10, ss16, ss24, ss31, ss45, ss48];

      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[24], 2);
      expect(s.positions[45], 1);
      expect(s.positions[10], 3);
      expect(s.positions[31], 4);
    });

    test('rule 5-2', () {
      List<ScatingScores> lSC = [ss11, ss21, ss32, ss41, ss51, ss61];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[11], 1);
      expect(s.positions[21], 2);
      expect(s.positions[32], 3);
      expect(s.positions[41], 4);
      expect(s.positions[51], 5);
      expect(s.positions[61], 6);
    });

    test('rule 6-1', () {
      List<ScatingScores> lSC = [
        ScatingScores('11144'.split(''), 6, 12),
        ScatingScores('32211'.split(''), 6, 22),
        ScatingScores('25522'.split(''), 6, 32),
        ScatingScores('43453'.split(''), 6, 42),
        ScatingScores('54335'.split(''), 6, 52),
        ScatingScores('66666'.split(''), 6, 62)
      ];

      ScatingCalc s = ScatingCalc.input(lSC);
      // expect(s.errorMessage, '');
      expect(s.positions[12], 1);
      expect(s.positions[22], 2);
      expect(s.positions[32], 3);
      expect(s.positions[42], 4);
      expect(s.positions[52], 5);
      expect(s.positions[62], 6);
    });

    test('rule 6-2', () {
      List<ScatingScores> lSC = [
        ScatingScores('3153123'.split(''), 6, 12),
        ScatingScores('1411212'.split(''), 6, 23),
        ScatingScores('4222334'.split(''), 6, 34),
        ScatingScores('6546465'.split(''), 6, 45),
        ScatingScores('2334551'.split(''), 6, 56),
        ScatingScores('5665646'.split(''), 6, 67)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[12], 2);
      expect(s.positions[23], 1);
      expect(s.positions[34], 3);
      expect(s.positions[45], 5);
      expect(s.positions[56], 4);
      expect(s.positions[67], 6);
    });

    test('rule 7-a', () {
      List<ScatingScores> lSC = [
        ScatingScores('46666'.split(''), 6, 15),
        ScatingScores('55111'.split(''), 6, 26),
        ScatingScores('61334'.split(''), 6, 37),
        ScatingScores('14225'.split(''), 6, 48),
        ScatingScores('22552'.split(''), 6, 59),
        ScatingScores('33443'.split(''), 6, 70)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[15], 6);
      expect(s.positions[26], 1);
      expect(s.positions[37], 4);
      expect(s.positions[48], 2);
      expect(s.positions[59], 3);
      expect(s.positions[70], 5);
    });

    test('rule 7-a-2', () {
      List<ScatingScores> lSC = [
        ScatingScores('11155'.split(''), 6, 15),
        ScatingScores('22514'.split(''), 6, 26),
        ScatingScores('55222'.split(''), 6, 37),
        ScatingScores('33461'.split(''), 6, 48),
        ScatingScores('44333'.split(''), 6, 59),
        ScatingScores('66646'.split(''), 6, 70)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[15], 1);
      expect(s.positions[26], 2);
      expect(s.positions[37], 3);
      expect(s.positions[48], 4);
      expect(s.positions[59], 5);
      expect(s.positions[70], 6);
    });

    test('rule 7-b', () {
      List<ScatingScores> lSC = [
        ScatingScores('5354652'.split(''), 6, 15),
        ScatingScores('3143511'.split(''), 6, 26),
        ScatingScores('1422234'.split(''), 6, 37),
        ScatingScores('2231423'.split(''), 6, 48),
        ScatingScores('4515146'.split(''), 6, 59),
        ScatingScores('6666365'.split(''), 6, 70)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[15], 5);
      expect(s.positions[26], 3);
      expect(s.positions[37], 2);
      expect(s.positions[48], 1);
      expect(s.positions[59], 4);
      expect(s.positions[70], 6);
    });

    test('rule 7-b-2', () {
      List<ScatingScores> lSC = [
        ScatingScores('21511'.split(''), 6, 14),
        ScatingScores('12255'.split(''), 6, 24),
        ScatingScores('56122'.split(''), 6, 34),
        ScatingScores('33336'.split(''), 6, 44),
        ScatingScores('44464'.split(''), 6, 54),
        ScatingScores('65643'.split(''), 6, 64)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[14], 1);
      expect(s.positions[24], 2);
      expect(s.positions[34], 3);
      expect(s.positions[44], 4);
      expect(s.positions[54], 5);
      expect(s.positions[64], 6);
    });

    test('rule 8-1', () {
      List<ScatingScores> lSC = [
        ScatingScores('43532'.split(''), 6, 16),
        ScatingScores('32241'.split(''), 6, 17),
        ScatingScores('21154'.split(''), 6, 18),
        ScatingScores('54323'.split(''), 6, 19),
        ScatingScores('15416'.split(''), 6, 20),
        ScatingScores('66665'.split(''), 6, 21)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[16], 3.5);
      expect(s.positions[17], 2);
      expect(s.positions[18], 1);
      expect(s.positions[19], 3.5);
      expect(s.positions[20], 5);
      expect(s.positions[21], 6);
    });

    test('rule 8-2', () {
      List<ScatingScores> lSC = [
        ScatingScores('1234567'.split(''), 7, 16),
        ScatingScores('2345671'.split(''), 7, 17),
        ScatingScores('3456712'.split(''), 7, 18),
        ScatingScores('4567123'.split(''), 7, 19),
        ScatingScores('5671234'.split(''), 7, 20),
        ScatingScores('6712345'.split(''), 7, 21),
        ScatingScores('7123456'.split(''), 7, 22)
      ];
      ScatingCalc s = ScatingCalc.input(lSC);
      expect(s.positions[16], 4);
      expect(s.positions[17], 4);
      expect(s.positions[18], 4);
      expect(s.positions[19], 4);
      expect(s.positions[20], 4);
      expect(s.positions[21], 4);
      expect(s.positions[22], 4);
    });
  });

  group('Scores', () {
    test('compare 1', () {
      ScatingScores s1 = ScatingScores('15112'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('22541'.split(""), 6, 0);
      expect(s1.compareTo(s2), -1);
    });

    test('compare 3', () {
      ScatingScores s2 = ScatingScores('15112'.split(""), 6, 0);
      ScatingScores s1 = ScatingScores('22541'.split(""), 6, 0);
      expect(s1.compareTo(s2), 1);
    });

    test('compare 4', () {
      ScatingScores s1 = ScatingScores('15112'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('51455'.split(""), 6, 0);
      expect(s1.compareTo(s2), -1);
    });

    test('compare 5', () {
      ScatingScores s1 = ScatingScores('43453'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('54335'.split(""), 6, 0);
      expect(s1.compareTo(s2), -1);
    });

    test('compare 6 ', () {
      ScatingScores s1 = ScatingScores('3153123'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('1411212'.split(""), 6, 0);
      expect(s1.compareTo(s2), 1);
    });

    test('compare 7-1 ', () {
      ScatingScores s1 = ScatingScores('14225'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('22552'.split(""), 6, 0);
      expect(s1.compareTo(s2), -1);
    });

    test('compare 7-1-2 ', () {
      ScatingScores s1 = ScatingScores('33461'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('44333'.split(""), 6, 0);
      expect(s2.compareTo(s1), 1);
    });

    test('compare эквал ', () {
      ScatingScores s1 = ScatingScores('54323'.split(""), 6, 0);
      ScatingScores s2 = ScatingScores('43532'.split(""), 6, 0);
      expect(s1.compareTo(s2), 0);
    });
  });
  test('ищем ошибку', () {
    var one = ScatingScores('21511'.split(''), 6, 14);
    var two = ScatingScores('12255'.split(''), 6, 24);
    var tree = ScatingScores('56122'.split(''), 6, 34);
    var four = ScatingScores('33336'.split(''), 6, 44);
    var fvier = ScatingScores('44464'.split(''), 6, 54);
    var six = ScatingScores('65643'.split(''), 6, 64);
    two.compareTo(four);
  });
}
