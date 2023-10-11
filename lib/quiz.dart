import 'package:flutter/material.dart';
import 'package:my_quiz/data/questions.dart';
import 'package:my_quiz/question_screen.dart';
import 'package:my_quiz/result_screen.dart';
import 'package:my_quiz/start_screen.dart';

var startAlignment = Alignment.topLeft;
var endAlignment = Alignment.bottomRight;

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() {
    return _QuizState();
  }
}

class _QuizState extends State<Quiz> {
  List<String> selectedAnswers = [];
  var activeScreen = 'start-screen';

  void switchScreen() {
    setState(() {
      activeScreen = 'question-screen';
    });
  }

  void chooseAnswer(String answer) {
    selectedAnswers.add(answer);

    if (selectedAnswers.length == questions.length) {
      setState(() {
        //selectedAnswers = [];
        activeScreen = 'result-screen';
      });
    }
  }

  void restartQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'question-screen';
    });
  }

  void exitQuiz() {
    setState(() {
      selectedAnswers = [];
      activeScreen = 'start-screen';
    });
  }

  // Widget? activeScreen;

  //@override
  //void initState() {
  //activeScreen = StartScreen(switchScreen);
  //super.initState();
  //}

  //void switchScreen() {
  //setState(() {
  //activeScreen = const QuestionScreen();
  //});
  //}

  @override
  Widget build(context) {
    Widget screenWidget = StartScreen(switchScreen);

    if (activeScreen == 'question-screen') {
      screenWidget = QuestionScreen(
        onSelectAnswer: chooseAnswer,
      );
    }

    if (activeScreen == 'result-screen') {
      screenWidget = ResultsScreen(
        chosenAnswers: selectedAnswers,
        onRestart: restartQuiz,
        onExit: exitQuiz,
      );
    }

   

    
    //Ternary Operator
    //final screenWidget = activeScreen == 'start-screen'? StartScreen(switchScreen)
    //: const QuestionsScreen();

    //IF condition example
    //Widget screenWidget = StartScreen(switchScreen);
    //if (activeScreen == 'questions-screen') {
    //screenWidget = const QuestionScreen();
    //}

    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 78, 13, 151),
              Color.fromARGB(255, 107, 15, 168),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
          //Ternary Operator
          //child: screenWidget,(example for in Widget)
          //child: activeScreen, (example for normal way)
          child: screenWidget,
        ),
      ),
    );
  }
}
