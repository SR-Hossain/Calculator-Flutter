import 'package:flutter/material.dart';
import 'package:flutter_calculator/button.dart';

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
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  var userQuestion = '453';
  var userAnswer = '234';


  final List<String> buttons = [
    'C', 'DEL', '%', '/',
    '9', '8', '7', 'x',
    '6', '5', '4', '-',
    '3', '2', '1', '+',
    '0', '.', 'ANS', '=',
  ];


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.deepPurple[100],
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Container(child: Text(userQuestion, style: TextStyle(fontSize: 40)), alignment: Alignment.centerLeft,),
                  Container(child: Text(userAnswer), alignment: Alignment.centerRight,),

                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                // padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, /*mainAxisSpacing: 10, crossAxisSpacing: 10*/),
                itemBuilder: (BuildContext context, int index) => MyButton(buttonText: buttons[index], color: index==1?Colors.red : index==0?Colors.green: purpleWhite(isOperator(buttons[index])), textColor: whitePurple(isOperator(buttons[index]))),
              ),

            ), 
            
          ),
        ],
      ),

      // body: Column(children: [],)
    );
  }
}

gridWithFixedColumn(int x) =>
    SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: x);


Color whitePurple(bool x) => x ? Colors.white : Colors.deepPurple;
Color purpleWhite(bool x) => !x ? Colors.white : Colors.deepPurple;
Color purpleGrey(bool x) => !x ? Colors.black : Colors.deepPurple;
bool isOperator(String x) => '/%x-+='.contains(x);