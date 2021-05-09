import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quizzler/domain/questions_brain.dart';
import 'package:quizzler/models/question.dart';

QuestionBrain _questionBrain = QuestionBrain();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> answersKeeper = [];
  late Question question;

  void _getQuestion() {
    Question? nextQuestion = _questionBrain.getNextQuestion();
    if (nextQuestion == null) {
      print('the last');
    } else {
      question = nextQuestion;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getQuestion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(20.0),
                child: Text(
                  question.questionText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25, color: Colors.white),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: window.physicalSize.width,
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.green),
                onPressed: () => _checkAnswer(true),
                child: Text(
                  'TRUE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: window.physicalSize.width,
              padding: const EdgeInsets.all(20.0),
              child: TextButton(
                style: TextButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => _checkAnswer(false),
                child: Text(
                  'FALSE',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              scrollDirection: Axis.horizontal,
              children: answersKeeper
                  .map((answer) => answer
                      ? Icon(
                          Icons.check,
                          color: Colors.green,
                          size: 45.0,
                        )
                      : Icon(
                          Icons.close,
                          color: Colors.red,
                          size: 45.0,
                        ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  void _checkAnswer(bool userAnswer) {
    setState(() {
      answersKeeper.add(userAnswer == question.questionAnswer);
    });
    _getQuestion();
  }
}
