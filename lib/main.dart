import 'package:flutter/material.dart';
import 'buttons.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var userQuestion = '';
  var userAnswer = '0';

  final List<String> buttons = [
    'AC',
    '/',
    '%',
    'DEL',
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
    '00',
    '.',
    '=',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      /*appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text('MR. CALC'),
        //elevation: 5,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontWeight: FontWeight.bold,
          fontSize: 28.0,
        ),
      ),*/
      body: Column(
        // for initial base of the app
        children: <Widget>[
          Expanded(
            child: Container(
              color: const Color.fromARGB(255, 1, 0, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      userQuestion,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 30.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 72),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      userAnswer,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 60.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GridView.builder(
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (BuildContext context, int index) {
                //clear button
                if (index == 0) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = '';
                        userAnswer = '0';
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.grey[300],
                    textColor: Colors.black,
                  );
                }
                //delete button
                else if (index == 3) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion = userQuestion.substring(
                            0, (userQuestion.length - 1));
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromARGB(255, 250, 179, 38),
                    textColor: const Color.fromARGB(255, 255, 255, 255),
                  );
                }
                // = button
                else if (index == 19) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        equalCalled();
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromARGB(255, 250, 179, 38),
                    textColor: const Color.fromARGB(255, 255, 255, 255),
                  );
                } else if (index == 1 || index == 2) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: Colors.grey[300],
                    textColor: Colors.black,
                  );
                } else if (index == 7 ||
                    index == 11 ||
                    index == 15 ||
                    index == 19) {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromARGB(255, 250, 179, 38),
                    textColor: const Color.fromARGB(255, 255, 255, 255),
                  );
                } else {
                  return MyButton(
                    buttonTapped: () {
                      setState(() {
                        userQuestion += buttons[index];
                      });
                    },
                    buttonText: buttons[index],
                    color: const Color.fromARGB(255, 71, 69, 69),
                    textColor: const Color.fromARGB(255, 255, 255, 255),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  //check operator as there will be different colors in numbers and operators buttons

  //yellow
  bool isOperator(String a) {
    if (a == 'DEL' || a == 'x' || a == '-' || a == '+' || a == '=') {
      return true;
    } else {
      return false;
    }
  }

  //dark grey
  bool isdigit(String a) {
    if (a == '7' ||
        a == '8' ||
        a == '9' ||
        a == '4' ||
        a == '5' ||
        a == '6' ||
        a == '1' ||
        a == '2' ||
        a == '3' ||
        a == '0' ||
        a == '00' ||
        a == '.') {
      return false;
    } else {
      return true;
    }
  }

  //light grey
  bool isAC(String a) {
    if (a == 'AC' || a == '/' || a == '%') {
      return true;
    } else {
      return false;
    }
  }

  void equalCalled() {
    String q = userQuestion;
    q = q.replaceAll('x', '*');
    Parser p = Parser();
    Expression exp = p.parse(q);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);

    userAnswer = eval.toString();
  }
}
