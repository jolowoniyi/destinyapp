import 'package:flutter/material.dart';
import 'question_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



Quizbrain quizbrain = Quizbrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> scorekeeper = [

  ];

  void checkAnswer(bool userPickedAnswer) {


    bool correctAnswers = quizbrain.getQuestionAnswer();

    setState(() {

    if (quizbrain.isFinished()){
      Alert(
        context: context,
        title: "YOU FINISHED!",
        desc: 'You\'ve reached the end of the quiz.',
        buttons: [
          DialogButton(
            child: Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),

            onPressed: () {
              return  Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
      quizbrain.reset();
      scorekeeper.clear();
    }
    else {
      if (userPickedAnswer == correctAnswers) {
        print('User got it right');
        scorekeeper.add(Icon(Icons.check, color: Colors.green));
      }
      else {
        print('User got it wrong');
        scorekeeper.add(Icon(Icons.close, color: Colors.red));
      }

      quizbrain.nextQuestion();
    }
    });
        }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              textColor: Colors.white,
              color: Colors.green,
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                checkAnswer(true);

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: FlatButton(
              color: Colors.red,
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                checkAnswer(false);

              },
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
        //TODO: Add a Row here as your score keeper
      ],
    );
  }
}

