import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BMI Rechner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'BMI Rechner Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentSliderValue = 80;
  TextEditingController sliderController = TextEditingController();
  int _currentSliderValue2 = 180;
  TextEditingController sliderController2 = TextEditingController();
  double weight = 50;
  double height = 150;
  double bmi = 24.69;

  void calculateBmi() {
    if (_currentSliderValue2 <= 0 || _currentSliderValue <= 0) {
      setState(() {
        bmi = 1.0;
      });
    } else {
      double newBMI =
          _currentSliderValue / pow(_currentSliderValue2.toDouble() / 100, 2);
      setState(() {
        bmi = newBMI;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                      color: Colors.green,
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {},
                        children: [
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return const ListTile(
                                title: Text('< 17,5'),
                              );
                            },
                            body: const ListTile(
                              title: Text('kritisches Untergewicht'),
                              subtitle: Text(
                                  'Achtung ein BMI-Wert unter 17,5 ist bedenklich.'),
                            ),
                            isExpanded: false,
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return const ListTile(
                                title: Text('17,5 - 20'),
                              );
                            },
                            body: const ListTile(
                              title: Text('Untergewicht'),
                              subtitle: Text('Ihr BMI ist sehr niedrig'),
                            ),
                            isExpanded: false,
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return const ListTile(
                                title: Text('20 - 26'),
                              );
                            },
                            body: const ListTile(
                              title: Text('Normalgewicht'),
                              subtitle: Text('Ihr BMI ist im gesunden Rahmen.'),
                            ),
                            isExpanded: true,
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return const ListTile(
                                title: Text('26 - 31'),
                              );
                            },
                            body: const ListTile(
                              title: Text('Leichtes Übergewicht'),
                              subtitle: Text('Ihr BMI ist leicht erhöht.'),
                            ),
                            isExpanded: false,
                          ),
                          ExpansionPanel(
                            headerBuilder:
                                (BuildContext context, bool isExpanded) {
                              return const ListTile(
                                title: Text('> 31'),
                              );
                            },
                            body: const ListTile(
                              title: Text('Übergewicht'),
                              subtitle:
                                  Text('Ihr BMI weist auf Übergewicht hin.'),
                            ),
                            isExpanded: false,
                          ),
                        ],
                      )),
                ),
                Column(children: [
                  Container(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    child: Image.asset('assets/images/man-shape.png'),
                  ),
                  const Text('Gewicht in Kilogramm'),
                  Text('$_currentSliderValue'),
                  SizedBox(
                    width: 500,
                    child: Slider(
                      value: _currentSliderValue.toDouble(),
                      min: 40,
                      max: 120,
                      divisions: 200,
                      activeColor: Colors.green,
                      label: _currentSliderValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValue = value.toInt();
                          sliderController.text =
                              _currentSliderValue.toString();
                          calculateBmi();
                          print('Gewicht $_currentSliderValue kg');
                        });
                      },
                    ),
                  ),
                ]),
                Expanded(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Column(
                        children: [
                          const Text('Körpergröße in Zentimetern'),
                          Text('$_currentSliderValue2'),
                          SizedBox(
                            width: 500,
                            child: Slider(
                              value: _currentSliderValue2.toDouble(),
                              min: 160,
                              max: 200,
                              divisions: 200,
                              activeColor: Colors.green,
                              label: _currentSliderValue2.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _currentSliderValue2 = value.toInt();
                                  sliderController2.text =
                                      _currentSliderValue2.toString();
                                  calculateBmi();
                                  print(' Größe $_currentSliderValue2 cm');
                                });
                              },
                            ),
                          ),
                        ],
                      )),
                ),
              ],
            ),
            const Text('ihr Body-Mass-Index'),
            Text('${bmi.toStringAsFixed(2)}'),
          ],
        )));
  }
}
