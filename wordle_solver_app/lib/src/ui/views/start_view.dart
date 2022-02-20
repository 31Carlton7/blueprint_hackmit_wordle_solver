import 'package:flutter/material.dart';
import 'package:wordle_solver_app/src/config/constants.dart';
import 'package:wordle_solver_app/src/ui/views/guessing_view.dart';

class StartView extends StatelessWidget {
  const StartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 23),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
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
                  'Welcome to the WORDLE SOLVER',
                  style: Theme.of(context).textTheme.headline4?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (context) => const GuessingView()),
                  );
                },
                style: ButtonStyle(
                  minimumSize:
                      MaterialStateProperty.all<Size>(const Size(130, 130)),
                  shape: MaterialStateProperty.all<OutlinedBorder>(
                    const StadiumBorder(
                      side: BorderSide(color: Color(0xFFF87171), width: 3),
                    ),
                  ),
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xFFDC2626),
                  ),
                ),
                child: Text(
                  'Start',
                  style: Theme.of(context).textTheme.button?.copyWith(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'By the 4.0 Musketeers',
                style: Theme.of(context).textTheme.headline5?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
