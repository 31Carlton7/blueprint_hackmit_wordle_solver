import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wordle_solver_app/src/config/constants.dart';
import 'package:wordle_solver_app/src/functions/dictionary.dart';

import 'package:wordle_solver_app/src/functions/wordle_solver.dart';

class GuessingView extends StatefulWidget {
  const GuessingView({Key? key}) : super(key: key);

  @override
  _GuessingViewState createState() => _GuessingViewState();
}

class _GuessingViewState extends State<GuessingView> {
  final _dictionary = Dictionary();

  List<TextEditingController> controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  static const kSpacingBetweenInputs = 7.0;
  static const kSizeOfInput = 65.0;

  static const grayColor = Color(0xFFE5E7EB);
  static const yellowColor = Color(0xFFD1B036);
  static const greenColor = Color(0xFF6AAA64);

  var colorOfBoxOne = grayColor;
  var colorOfBoxTwo = grayColor;
  var colorOfBoxThree = grayColor;
  var colorOfBoxFour = grayColor;
  var colorOfBoxFive = grayColor;

  var _returnedGuess = 'crane';

  bool _colorIsGray(Color c) {
    return c.value == grayColor.value;
  }

  bool _colorIsYellow(Color c) {
    return c.value == yellowColor.value;
  }

  bool _colorIsGreen(Color c) {
    return c.value == greenColor.value;
  }

  void _changeColor(int c) {
    if (c == 0) {
      if (_colorIsGray(colorOfBoxOne)) {
        colorOfBoxOne = yellowColor;
      } else if (_colorIsYellow(colorOfBoxOne)) {
        colorOfBoxOne = greenColor;
      } else if (_colorIsGreen(colorOfBoxOne)) {
        colorOfBoxOne = grayColor;
      }
    } else if (c == 1) {
      if (_colorIsGray(colorOfBoxTwo)) {
        colorOfBoxTwo = yellowColor;
      } else if (_colorIsYellow(colorOfBoxTwo)) {
        colorOfBoxTwo = greenColor;
      } else if (_colorIsGreen(colorOfBoxTwo)) {
        colorOfBoxTwo = grayColor;
      }
    } else if (c == 2) {
      if (_colorIsGray(colorOfBoxThree)) {
        colorOfBoxThree = yellowColor;
      } else if (_colorIsYellow(colorOfBoxThree)) {
        colorOfBoxThree = greenColor;
      } else if (_colorIsGreen(colorOfBoxThree)) {
        colorOfBoxThree = grayColor;
      }
    } else if (c == 3) {
      if (_colorIsGray(colorOfBoxFour)) {
        colorOfBoxFour = yellowColor;
      } else if (_colorIsYellow(colorOfBoxFour)) {
        colorOfBoxFour = greenColor;
      } else if (_colorIsGreen(colorOfBoxFour)) {
        colorOfBoxFour = grayColor;
      }
    } else if (c == 4) {
      if (_colorIsGray(colorOfBoxFive)) {
        colorOfBoxFive = yellowColor;
      } else if (_colorIsYellow(colorOfBoxFive)) {
        colorOfBoxFive = greenColor;
      } else if (_colorIsGreen(colorOfBoxFive)) {
        colorOfBoxFive = grayColor;
      }
    }

    setState(() {});
  }

  Widget _buttonChild() {
    return Text(
      'Guess',
      style: Theme.of(context).textTheme.button?.copyWith(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
    );
  }

  String _evaluateGuess() {
    var guessOne = 0;
    var guessTwo = 0;
    var guessThree = 0;
    var guessFour = 0;
    var guessFive = 0;

    if (_colorIsGray(colorOfBoxOne)) {
      guessOne = 0;
    } else if (_colorIsYellow(colorOfBoxOne)) {
      guessOne = 1;
    } else if (_colorIsGreen(colorOfBoxOne)) {
      guessOne = 2;
    }

    if (_colorIsGray(colorOfBoxTwo)) {
      guessTwo = 0;
    } else if (_colorIsYellow(colorOfBoxTwo)) {
      guessTwo = 1;
    } else if (_colorIsGreen(colorOfBoxTwo)) {
      guessTwo = 2;
    }

    if (_colorIsGray(colorOfBoxThree)) {
      guessThree = 0;
    } else if (_colorIsYellow(colorOfBoxThree)) {
      guessThree = 1;
    } else if (_colorIsGreen(colorOfBoxThree)) {
      guessThree = 2;
    }

    if (_colorIsGray(colorOfBoxFour)) {
      guessFour = 0;
    } else if (_colorIsYellow(colorOfBoxFour)) {
      guessFour = 1;
    } else if (_colorIsGreen(colorOfBoxFour)) {
      guessFour = 2;
    }

    if (_colorIsGray(colorOfBoxFive)) {
      guessFive = 0;
    } else if (_colorIsYellow(colorOfBoxFive)) {
      guessFive = 1;
    } else if (_colorIsGreen(colorOfBoxFive)) {
      guessFive = 2;
    }

    List<PositionLetter> correctLetterCorrectPosition = [];
    List<PositionLetter> correctLetterIncorrectPosition = [];
    List<String> incorrectLetter = [];

    print(guessTwo == 0);

    if (guessOne == 2) {
      correctLetterCorrectPosition.add(PositionLetter(0, controllers[0].text));
    } else if (guessOne == 1) {
      correctLetterIncorrectPosition
          .add(PositionLetter(0, controllers[0].text));
    } else {
      incorrectLetter.add(controllers[0].text);
    }

    if (guessTwo == 2) {
      correctLetterCorrectPosition.add(PositionLetter(1, controllers[1].text));
    } else if (guessTwo == 1) {
      print('running');
      correctLetterIncorrectPosition
          .add(PositionLetter(1, controllers[1].text));
    } else {
      incorrectLetter.add(controllers[1].text);
    }

    if (guessThree == 2) {
      correctLetterCorrectPosition.add(PositionLetter(2, controllers[2].text));
    } else if (guessThree == 1) {
      correctLetterIncorrectPosition
          .add(PositionLetter(2, controllers[2].text));
    } else {
      incorrectLetter.add(controllers[2].text);
    }

    if (guessFour == 2) {
      correctLetterCorrectPosition.add(PositionLetter(3, controllers[3].text));
    } else if (guessFour == 1) {
      correctLetterIncorrectPosition
          .add(PositionLetter(3, controllers[3].text));
    } else {
      incorrectLetter.add(controllers[3].text);
    }

    if (guessFive == 2) {
      correctLetterCorrectPosition.add(PositionLetter(4, controllers[4].text));
    } else if (guessFive == 1) {
      correctLetterIncorrectPosition
          .add(PositionLetter(4, controllers[4].text));
    } else {
      incorrectLetter.add(controllers[4].text);
    }

    List<String> answers = solve(
      _dictionary,
      correctLetterCorrectPosition,
      correctLetterIncorrectPosition,
      incorrectLetter,
    );

    if (answers.isEmpty) {
      return "No Answer Found.";
    }

    return answers[0];
  }

  Widget _colorChangeButton(int c) {
    return GestureDetector(
      onTap: () {
        _changeColor(c);
      },
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Colors.black, width: 2),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: grayColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: yellowColor,
                shape: BoxShape.circle,
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: const BoxDecoration(
                color: greenColor,
                shape: BoxShape.circle,
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _dictionary.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: GestureDetector(
            onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.only(top: 120, bottom: 50),
                    child: Image.asset(
                      kWorldLogoImage,
                      height: 70,
                      width: 70,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Enter your result 😺',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Try "$_returnedGuess"',
                      style: Theme.of(context).textTheme.headline5?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 40),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Container(
                              height: kSizeOfInput,
                              width: kSizeOfInput,
                              decoration: BoxDecoration(
                                color: colorOfBoxOne,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: TextField(
                                autocorrect: false,
                                controller: controllers[0],
                                decoration: const InputDecoration(
                                  hintText: '_',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]")),
                                  LowerCaseTextFormatter(),
                                ],
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                            _colorChangeButton(0),
                          ],
                        ),
                        const SizedBox(width: kSpacingBetweenInputs),
                        Column(
                          children: [
                            Container(
                              height: kSizeOfInput,
                              width: kSizeOfInput,
                              decoration: BoxDecoration(
                                color: colorOfBoxTwo,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: TextField(
                                autocorrect: false,
                                controller: controllers[1],
                                decoration: const InputDecoration(
                                  hintText: '_',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]")),
                                  LowerCaseTextFormatter(),
                                ],
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                            _colorChangeButton(1),
                          ],
                        ),
                        const SizedBox(width: kSpacingBetweenInputs),
                        Column(
                          children: [
                            Container(
                              height: kSizeOfInput,
                              width: kSizeOfInput,
                              decoration: BoxDecoration(
                                color: colorOfBoxThree,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: TextField(
                                autocorrect: false,
                                controller: controllers[2],
                                decoration: const InputDecoration(
                                  hintText: '_',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]")),
                                  LowerCaseTextFormatter(),
                                ],
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                            _colorChangeButton(2),
                          ],
                        ),
                        const SizedBox(width: kSpacingBetweenInputs),
                        Column(
                          children: [
                            Container(
                              height: kSizeOfInput,
                              width: kSizeOfInput,
                              decoration: BoxDecoration(
                                color: colorOfBoxFour,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: TextField(
                                autocorrect: false,
                                controller: controllers[3],
                                decoration: const InputDecoration(
                                  hintText: '_',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]")),
                                  LowerCaseTextFormatter(),
                                ],
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                            _colorChangeButton(3),
                          ],
                        ),
                        const SizedBox(width: kSpacingBetweenInputs),
                        Column(
                          children: [
                            Container(
                              height: kSizeOfInput,
                              width: kSizeOfInput,
                              decoration: BoxDecoration(
                                color: colorOfBoxFive,
                                borderRadius: BorderRadius.circular(8),
                                border:
                                    Border.all(color: Colors.black, width: 3),
                              ),
                              child: TextField(
                                autocorrect: false,
                                controller: controllers[4],
                                decoration: const InputDecoration(
                                  hintText: '_',
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.allow(
                                      RegExp("[a-zA-Z]")),
                                  LowerCaseTextFormatter(),
                                ],
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                textCapitalization:
                                    TextCapitalization.characters,
                              ),
                            ),
                            _colorChangeButton(4),
                          ],
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _returnedGuess = _evaluateGuess();
                      });
                    },
                    style: ButtonStyle(
                      minimumSize:
                          MaterialStateProperty.all<Size>(const Size(130, 130)),
                      maximumSize:
                          MaterialStateProperty.all<Size>(const Size(130, 130)),
                      shape: MaterialStateProperty.all<OutlinedBorder>(
                        const StadiumBorder(
                          side: BorderSide(color: Color(0xFF7DD3FC), width: 3),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF0EA5E9),
                      ),
                    ),
                    child: _buttonChild(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class LowerCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toLowerCase(),
      selection: newValue.selection,
    );
  }
}
