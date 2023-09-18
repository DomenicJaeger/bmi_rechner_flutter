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
  int _bodyWeight = 80;
  TextEditingController weightController = TextEditingController();
  int _bodyHeight = 180;
  TextEditingController heightController = TextEditingController();
  double weight = 50;
  double height = 150;
  double bmi = 24.69;

//Map für ExpansionPanels
  Map<int, bool> expansionPanelStates = {
    0: false,
    1: false,
    2: true,
    3: false,
    4: false,
  };

//Berechnung des BMI
  void calculateBmi() {
    if (_bodyHeight <= 0 || _bodyWeight <= 0) {
      setState(() {
        bmi = 1.0;
      });
    } else {
      double newBmi = _bodyWeight / pow(_bodyHeight.toDouble() / 100, 2);
      setState(() {
        bmi = newBmi;
      });
    }
    updateExpansionPanelBasedOnBMI();
  }

// Öffnen und schließen von ExpansionPanels abhängig von BMI
  void updateExpansionPanelBasedOnBMI() {
    if (bmi < 17.5) {
      setState(() {
        expansionPanelStates[0] = true;
        expansionPanelStates[1] = false;
        expansionPanelStates[2] = false;
        expansionPanelStates[3] = false;
        expansionPanelStates[4] = false;
      });
    } else if (bmi >= 17.5 && bmi < 20) {
      setState(() {
        expansionPanelStates[0] = false;
        expansionPanelStates[1] = true;
        expansionPanelStates[2] = false;
        expansionPanelStates[3] = false;
        expansionPanelStates[4] = false;
      });
    } else if (bmi >= 20 && bmi < 26) {
      setState(() {
        expansionPanelStates[0] = false;
        expansionPanelStates[1] = false;
        expansionPanelStates[2] = true;
        expansionPanelStates[3] = false;
        expansionPanelStates[4] = false;
      });
    } else if (bmi >= 26 && bmi < 31) {
      setState(() {
        expansionPanelStates[0] = false;
        expansionPanelStates[1] = false;
        expansionPanelStates[2] = false;
        expansionPanelStates[3] = true;
        expansionPanelStates[4] = false;
      });
    } else {
      setState(() {
        expansionPanelStates[0] = false;
        expansionPanelStates[1] = false;
        expansionPanelStates[2] = false;
        expansionPanelStates[3] = false;
        expansionPanelStates[4] = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 239, 229),
        appBar: AppBar(
          backgroundColor: Colors.green,
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
                      width: 400.0,
                      color: Colors.green,

                      //ExpansionPanels mit Informationen bezüglich Über- Unter- und Normalgewicht
                      child: ExpansionPanelList(
                        expansionCallback: (int index, bool isExpanded) {
                          setState(() {
                            expansionPanelStates[index] = !isExpanded;
                          });
                        },
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
                            isExpanded: expansionPanelStates[0] ?? false,
                            canTapOnHeader: true,
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
                            isExpanded: expansionPanelStates[1] ?? false,
                            canTapOnHeader: true,
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
                            isExpanded: expansionPanelStates[2] ?? true,
                            canTapOnHeader: true,
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
                            isExpanded: expansionPanelStates[3] ?? false,
                            canTapOnHeader: true,
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
                            isExpanded: expansionPanelStates[4] ?? false,
                            canTapOnHeader: true,
                          ),
                        ],
                      )),
                ),

                //Anpassbares Bild, Breite und Höhe abhängig vom Wert der Slider
                Column(children: [
                  Transform.scale(
                    scaleX: _bodyWeight / 100,
                    scaleY: _bodyHeight / 200,
                    alignment: FractionalOffset.bottomCenter,
                    child: Image.asset('assets/images/man-shape.png'),
                  ),

                  //Slider für Körpergewicht
                  const Text('Gewicht in Kilogramm'),
                  Text('$_bodyWeight',
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  SizedBox(
                    width: 300,
                    child: Slider(
                      value: _bodyWeight.toDouble(),
                      min: 40,
                      max: 120,
                      divisions: 200,
                      activeColor: Colors.green,
                      label: _bodyWeight.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _bodyWeight = value.toInt();
                          weightController.text = _bodyWeight.toString();
                          calculateBmi();
                        });
                      },
                    ),
                  ),
                ]),

                //Rotierte Box um Slider für Körpergröße vertikal darzustellen
                Expanded(
                  child: RotatedBox(
                      quarterTurns: 3,
                      child: Column(
                        children: [
                          const Text('Körpergröße in Zentimetern'),
                          Text(
                            '$_bodyHeight',
                            style: const TextStyle(
                              color: Colors.green,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 500,
                            child: Slider(
                              value: _bodyHeight.toDouble(),
                              min: 160,
                              max: 200,
                              divisions: 200,
                              activeColor: Colors.green,
                              label: _bodyHeight.round().toString(),
                              onChanged: (double value) {
                                setState(() {
                                  _bodyHeight = value.toInt();
                                  heightController.text =
                                      _bodyHeight.toString();
                                  calculateBmi();
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
            Text(bmi.toStringAsFixed(2),
                style: const TextStyle(
                    color: Colors.green,
                    fontSize: 32,
                    fontWeight: FontWeight.bold)),
          ],
        )));
  }
}
