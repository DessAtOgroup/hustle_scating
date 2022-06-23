import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/gestures.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  const About({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: ListView(
        //crossAxisAlignment: CrossAxisAlignment.center,

        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                  style: TextStyle(color: Colors.blue),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'by ' 'Плоская утка \n',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () async {
                          final url = Uri(scheme: 'https', host: 'ogroup.pro');
                          if (await canLaunchUrl(url)) {
                            await launchUrl(url);
                          }
                        },
                    ),
                    TextSpan(
                        text: 'Специально для клуба современных танцев \n'),
                    TextSpan(
                        text: ' "Альтернатива", г.Барнаул',
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            launchUrl(Uri(
                                scheme: 'https',
                                host: 'vk.com',
                                path: '/dance_alternativa'));
                          })
                  ])),
          CupertinoButton(
              child: Text("Назад"),
              onPressed: () {
                Navigator.pop(context);
              })
        ],
      ),
    );
  }
}
