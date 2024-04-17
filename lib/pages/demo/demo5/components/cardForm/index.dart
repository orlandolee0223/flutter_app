import 'package:flutter/material.dart';
// components
import './form/index.dart';
import './result/index.dart';

class CardForm extends StatefulWidget {
  const CardForm({super.key});

  @override
  CardFormState createState() => CardFormState();
}

class CardFormState extends State<CardForm> {
  bool isResult = false;

  Widget renderContent() {
    if (isResult) {
      return const ResultView();
    }
    return FormView(
      handleType: (bool data) {
        setState(() {
          isResult = data;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 100),
        renderContent(),
      ],
    );
  }
}
