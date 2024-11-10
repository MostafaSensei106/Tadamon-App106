import 'dart:io';
import 'dart:math';

void main() {
  int correctCount = 0;
  int incorrectCount = 0;
  Random random = Random();
  int num1, num2;
  int correctAnswer;
  int userAnswer;
  String? input;

  print('Hay My Best Friend!');
  print('lets play a math game!');

  while (true) {
    num1 = random.nextInt(10) + 1;
    num2 = random.nextInt(10) + 1;
    correctAnswer = num1 * num2;

    print('What is $num1 × $num2?');
    input = stdin.readLineSync();

    try {
      userAnswer = int.parse(input!);
    } catch (e) {
      print("Please enter a valid number, My Friend!");
      continue;
    }

    if (userAnswer == correctAnswer) {
      print("Correct I Love It");
      correctCount++;
    } else {
      print(
          "Incorrect. The correct answer is $correctAnswer, My Friend Try Again!");
      incorrectCount++;
    }

    print("Would you like to try another Round My Friend? (y/n)");
    String? continueInput = stdin.readLineSync();
    if (continueInput == null || continueInput.toLowerCase() != 'y') {
      break;
    }
  }

  print(
      "\nYou answered $correctCount Math Problems correctly and $incorrectCount problems incorrectly.");
}
