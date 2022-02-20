import 'dictionary.dart';

class PositionLetter {
  final int position;
  final String letter;
  const PositionLetter(this.position, this.letter);
}

List<PositionLetter> prevCorrectLetters = [];
List<PositionLetter> prevMissedLetters = [];
List<String> prevIncorrectLetters = [];

List<String> solve(
    Dictionary dictionary,
    List<PositionLetter> correctLetterCorrectSpot,
    List<PositionLetter> correctLetterIncorrectSpot,
    List<String> incorrectLetter) {
  prevCorrectLetters.addAll(correctLetterCorrectSpot);
  prevMissedLetters.addAll(correctLetterIncorrectSpot);
  prevIncorrectLetters.addAll(incorrectLetter);

  List<String> answers = [];
  for (var i = 0; i < dictionary.getWords().length; i++) {
    String candidate = dictionary.getWords()[i];

    bool correctCandidate = true;

    // Case: correct letter correct spot.
    for (var j = 0; j < prevCorrectLetters.length; j++) {
      var pl = prevCorrectLetters[j];
      if (candidate[pl.position] != pl.letter) {
        correctCandidate = false;
        break;
      }
    }

    if (!correctCandidate) {
      continue;
    }

    // Case: correct letter incorrect spot.
    for (var j = 0; j < prevMissedLetters.length; j++) {
      var pl = prevMissedLetters[j];
      if (!(candidate.contains(pl.letter) &&
          candidate[pl.position] != pl.letter)) {
        correctCandidate = false;
        break;
      }
    }

    if (!correctCandidate) {
      continue;
    }

    // Case: incorrect letter.
    for (var j = 0; j < prevIncorrectLetters.length; j++) {
      if (candidate.contains(prevIncorrectLetters[j])) {
        correctCandidate = false;
        break;
      }
    }

    if (correctCandidate) {
      answers.add(candidate);
    }
  }
  return answers;
}
