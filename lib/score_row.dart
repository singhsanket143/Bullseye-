import 'package:flutter/material.dart';
import 'text_styles.dart';
import 'styled_button.dart';

class ScoreRow extends StatelessWidget {
  const ScoreRow(
      {Key? key,
      required this.totalScore,
      required this.round,
      required this.startOverCallback})
      : super(key: key);
  final int totalScore;
  final int round;
  final VoidCallback startOverCallback;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        StylesButton(
            icon: Icons.refresh,
            onPressed: () {
              startOverCallback();
            }),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: <Widget>[
              Text(
                'Score: ',
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                '$totalScore',
                style: ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.0, right: 32.0),
          child: Column(
            children: <Widget>[
              Text(
                'Round: ',
                style: LabelTextStyle.bodyText1(context),
              ),
              Text(
                '$round',
                style: ScoreNumberTextStyle.headline4(context),
              ),
            ],
          ),
        ),
        StylesButton(
          icon: Icons.info,
          onPressed: () {},
        )
      ],
    );
  }
}
