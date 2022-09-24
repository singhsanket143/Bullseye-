import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'control.dart';
import 'score_row.dart';
import 'game_model.dart';
import 'dart:math';

void main() {
  runApp(const BullsEye());
}

class BullsEye extends StatelessWidget {
  const BullsEye({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
    return MaterialApp(
      title: 'BullsEye',
      home: GamePage(),
    );
  }
}

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  late GameModel _model;
  @override
  void initState() {
    super.initState();
    _model = GameModel(Random().nextInt(100) + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Prompt(targetValue: _model.target),
            Control(
              model: _model,
            ),
            TextButton(
              onPressed: () {
                _showAlert(context);
              },
              child: const Text(
                'Hit Me',
                style: TextStyle(color: Colors.green),
              ),
            ),
            ScoreRow(
              totalScore: _model.totalScore,
              round: _model.round,
            ),
          ],
        ),
      ),
    );
  }

  int _pointsForCurrentRound() {
    const int maximumScore = 100;
    return maximumScore - _differenceAmount();
  }

  String _alertTitle() {
    int difference = _differenceAmount();
    String title;
    if (difference == 0) {
      title = 'Perfect!';
    } else if (difference < 5) {
      title = 'You almost had it!';
    } else if (difference <= 10) {
      title = 'Not bad, good try!';
    } else {
      title = 'Are you even trying ??';
    }
    return title;
  }

  int _differenceAmount() => (_model.target - _model.current).abs();

  void _showAlert(BuildContext context) {
    var okButton = TextButton(
      child: const Text('Awesome!'),
      onPressed: () {
        Navigator.of(context).pop();
        setState(() {
          _model.totalScore += _pointsForCurrentRound();
          _model.target = Random().nextInt(100) + 1;
          _model.round++;
        });
      },
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('${_alertTitle()}'),
            content: Text('The slider value is ${_model.current}.'
                'You Scored ${_pointsForCurrentRound()} points '),
            actions: [okButton],
            elevation: 5,
          );
        });
  }
}
