import 'package:flutter/material.dart';
import 'package:flutter_calculator/button.dart';
import 'package:math_expressions/math_expressions.dart';

void main() => runApp(const Calculator());

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) => const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
      );
}

var gridDelegate =
    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4);

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '';
  var darkMode = true;
  var darkModeIcon = const Icon(Icons.dark_mode);
  var lightModeIcon = const Icon(Icons.light_mode);
  var themeIcon = const Icon(Icons.dark_mode);
  var consoleBG = Colors.blue[100];
  var gridBG = Colors.blue[50];
  var fontColor = Colors.black;
  var buttonColor = Colors.white;
  var operatorButtonColor = const Color.fromARGB(255, 33, 150, 243);

  void changeColor(bool isDarkModeOn) {
    setState(() {
      darkMode = isDarkModeOn;
      themeIcon = darkMode ? darkModeIcon : lightModeIcon;

      if (isDarkModeOn) {
        consoleBG = const Color.fromARGB(255, 41, 38, 50);
        gridBG = const Color.fromARGB(255, 27, 24, 24);
        fontColor = Colors.white;
        buttonColor = Colors.black;
        operatorButtonColor = const Color.fromARGB(255, 7, 46, 77);
      } else {
        gridBG = Colors.blue[50];
        consoleBG = Colors.blue[100];
        fontColor = Colors.black;
        buttonColor = Colors.white;
        operatorButtonColor = Colors.blue;
      }
    });
  }

  final List<String> buttons = [
    'C',
    'DEL',
    '%',
    '/',
    '7',
    '8',
    '9',
    'x',
    '4',
    '5',
    '6',
    '-',
    '1',
    '2',
    '3',
    '+',
    '0',
    '.',
    'ANS',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
        backgroundColor: buttonColor,
        foregroundColor: fontColor,
        actions: <Widget>[
          IconButton(
            icon: themeIcon,
            onPressed: () => changeColor(darkMode),
          ),
        ],
      ),
      backgroundColor: gridBG,
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Container(
                  color: consoleBG,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Container(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            userQuestion,
                            style: TextStyle(fontSize: 40, color: fontColor),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            userAnswer,
                            style: TextStyle(fontSize: 50, color: fontColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: gridBG,
              child: GridView.builder(
                itemCount: buttons.length,
                // padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      4, /*mainAxisSpacing: 10, crossAxisSpacing: 10*/
                ),
                itemBuilder: (BuildContext context, int index) => MyButton(
                  buttonText: buttons[index],
                  color: index == 1
                      ? Colors.red
                      : index == 0
                          ? Colors.green
                          : isOperator(buttons[index])
                              ? operatorButtonColor
                              : buttonColor,
                  textColor:
                      isOperator(buttons[index]) ? Colors.white : fontColor,
                  buttonTapped: () {
                    if (index == 0) {
                      setState(() {
                        userQuestion = userAnswer = '';
                      });
                    } else if (index == 1) {
                      setState(() {
                        if (userQuestion.isNotEmpty) {
                          if (userQuestion.endsWith('ANS')) {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 3);
                          } else {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                          }
                        }
                      });
                    } else if (index == buttons.length - 1) {
                      setState(() {
                        equalPressed();
                      });
                    } else {
                      setState(() {
                        if (buttons[index] == '+' && userQuestion.isEmpty) {
                          userQuestion = 'ANS';
                        }
                        userQuestion += buttons[index];
                      });
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),

      // body: Column(children: [],)
    );
  }

  void equalPressed() {
    String finalQuestion = userQuestion
        .replaceAll('x', '*')
        .replaceAll('ANS', userAnswer.toString());
    Parser mathParser = Parser();
    Expression expression = mathParser.parse(finalQuestion);
    double answer = expression.evaluate(EvaluationType.REAL, ContextModel());
    userAnswer = answer.toString();
  }
}

gridWithFixedColumn(int x) =>
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: x);

Color whitePurple(bool x) => x ? Colors.white : Colors.deepPurple;
Color purpleWhite(bool x) => !x ? Colors.white : Colors.deepPurple;
Color purpleGrey(bool x) => !x ? Colors.black : Colors.deepPurple;
bool isOperator(String x) => '/%x-+='.contains(x);
