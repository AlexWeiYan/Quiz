import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_quiz/data/questions.dart';
import 'package:my_quiz/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen(
      {super.key,
      required this.chosenAnswers,
      required this.onRestart,
      required this.onExit});

  final List<String> chosenAnswers;
  final void Function() onRestart;
  final void Function() onExit;

  List<Map<String, Object>> getSummaryData() {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': chosenAnswers[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summaryData = getSummaryData();
    final numTotalQuestions = questions.length;
    final numTotalCorrectQuestions = summaryData.where((data) {
      return data['user_answer'] == data['correct_answer'];
    }).length;
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              'You answered $numTotalCorrectQuestions out of $numTotalQuestions questions correctly',
              style: GoogleFonts.ubuntu(
                color: Color.fromARGB(255, 231, 243, 5),
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            QuestionsSummary(getSummaryData()),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(height: 1),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Restart Quiz'),
            ),
            const SizedBox(height: 1),
            TextButton.icon(
              onPressed: onExit,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.exit_to_app_rounded),
              label: const Text('Exit Quiz'),
            )
          ],
        ),
      ),
    );
  }
}
