import 'package:flutter/material.dart';
import 'package:confetti/confetti.dart';
import 'package:test_app/quizz_question.dart';

class MatchQuestion extends StatefulWidget {
  final Question question;

  MatchQuestion({required this.question});

  @override
  _MatchQuestionState createState() => _MatchQuestionState();
}

class _MatchQuestionState extends State<MatchQuestion>
    with SingleTickerProviderStateMixin {
  String? selectedNumber;
  String? selectedWord;
  bool showFeedback = false;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void checkMatch() {
    if (selectedNumber != null && selectedWord != null) {
      bool isCorrect = false;
      for (var option in widget.question.options) {
        if (option.containsKey(selectedNumber) &&
            option[selectedNumber] == selectedWord) {
          isCorrect = true;
          break;
        }
      }

      if (isCorrect) {
        setState(() {
          _confettiController.play();
        });
        showFeedbackPopup(context, isCorrect: true);
      } else {
        showFeedbackPopup(context, isCorrect: false);
      }
      resetSelection();
    }
  }

  void resetSelection() {
    setState(() {
      selectedNumber = null;
      selectedWord = null;
    });
  }

  void showFeedbackPopup(BuildContext context, {required bool isCorrect}) {
    String message = isCorrect ? 'Correct!' : 'Incorrect';

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Stack(
          children: [
            if (isCorrect)
              ConfettiWidget(
                confettiController: _confettiController,
                blastDirectionality: BlastDirectionality.explosive,
                shouldLoop: false,
                colors: const [
                  Colors.green,
                  Colors.blue,
                  Colors.pink,
                  Colors.orange,
                  Colors.purple
                ],
              ),
            AlertDialog(
              backgroundColor: Colors.white,
              elevation: 10,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              title: Text(
                message,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: isCorrect ? Colors.green : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              content: Icon(
                isCorrect ? Icons.check_circle : Icons.cancel,
                color: isCorrect ? Colors.green : Colors.red,
                size: 100,
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(fontSize: 20, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.2;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: widget.question.options.length,
            itemBuilder: (context, index) {
              var option = widget.question.options[index];
              String number = option.keys.first;
              String word = option.values.first;

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedNumber = number;
                        checkMatch();
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: containerHeight,
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedNumber == number
                            ? Colors.blueAccent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.6),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          number,
                          style: TextStyle(
                            color: selectedNumber == number
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedWord = word;
                        checkMatch();
                      });
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: containerHeight,
                      width: MediaQuery.of(context).size.width * 0.4,
                      padding: EdgeInsets.all(20),
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: selectedWord == word
                            ? Colors.blueAccent
                            : Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.blue.withOpacity(0.6),
                          width: 2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          word,
                          style: TextStyle(
                            color: selectedWord == word
                                ? Colors.white
                                : Colors.black,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
