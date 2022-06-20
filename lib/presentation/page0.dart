import 'package:flutter/cupertino.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _pairCountController;

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
      //TODO поставить дуракоустойчивость. Не более 9 пар
      _pairCountController.text =
          (int.parse(_pairCountController.text) + 1).toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
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
              Navigator.push(
                context,
                CupertinoPageRoute(builder: (context) => const CalcTable()),
              );
            },
            child: const Text('Next'),
          ),
        ],
      ),
    );
  }
}

class CalcTable extends StatelessWidget {
  const CalcTable({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: CupertinoButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go back!'),
        ),
      ),
    );
  }
}
