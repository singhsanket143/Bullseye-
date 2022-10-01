import 'package:bullseye/styled_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'prompt.dart';
import 'control.dart';
import 'score_row.dart';
import 'game_model.dart';
import 'dart:math';
import 'hit_me_button.dart';

void main() {
  runApp(const BullsEye());
}

class BullsEye extends StatelessWidget {
  const BullsEye({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
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
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage('images/background.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Prompt(targetValue: _model.target),
              Control(
                model: _model,
              ),
              HitMeButton(
                  text: 'Hit Me',
                  onPressed: () {
                    _showAlert(context);
                  }),
              ScoreRow(
                totalScore: _model.totalScore,
                round: _model.round,
                startOverCallback: _startNewGame,
              ),
            ],
          ),
        ),
      ),
    );
  }

  int _pointsForCurrentRound() {
    const int maximumScore = 100;
    int bonusPoints = 0;
    int difference = _differenceAmount();
    if (difference == 0) {
      bonusPoints += 100;
    } else if (difference == 1) {
      bonusPoints += 50;
    }
    return maximumScore - _differenceAmount() + bonusPoints;
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

  void _startNewGame() {
    setState(() {
      _model.current = GameModel.sliderStart;
      _model.totalScore = GameModel.scoreStart;
      _model.round = GameModel.roundStart;
      _model.target = Random().nextInt(100) + 1;
    });
  }

  void _showAlert(BuildContext context) {
    var okButton = StylesButton(
      icon: Icons.close,
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
