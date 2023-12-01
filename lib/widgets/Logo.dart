import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkPermitsDataResourceLogo extends StatelessWidget {
  const WorkPermitsDataResourceLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(10),
        alignment: Alignment.topCenter,
        child: RichText(
            text: TextSpan(
          text: 'Data provided by Department of Enterprise, Trade and Employment',
          style: const TextStyle(
              fontSize: 10,
              fontStyle: FontStyle.italic,
              fontFamily: AutofillHints.url,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurpleAccent),
          recognizer: TapGestureRecognizer()
            ..onTap = () => launchUrl(Uri.parse(
                'https://enterprise.gov.ie/en/what-we-do/workplace-and-skills/employment-permits/statistics/')),
        )));
  }
}
