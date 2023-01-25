import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'numberpicker in showdialog exam'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIntYear = 1990;
  int _currentIntMonth = 7;
  int _currentIntDay = 10;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  Future<void> _showIntegerDialog(BuildContext context) {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('생년월일'),
            contentPadding: EdgeInsets.fromLTRB(0, 24, 0, 24),
            content: Container(
              height: 200,
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('년'),
                      _numberPickerInDialog(
                          context, _currentIntYear, 1940, 2020),
                    ],
                  ),
                  Column(
                    children: [
                      Text('월'),
                      _numberPickerInDialog(context, _currentIntMonth, 1, 12),
                    ],
                  ),
                  Column(
                    children: [
                      Text('일'),
                      _numberPickerInDialog(context, _currentIntDay, 1, 31),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Enable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  StatefulBuilder _numberPickerInDialog(
      context, _currentIntValue, minValue, maxValue) {
    return StatefulBuilder(
      builder: (context, setDialogState) {
        return NumberPicker(
            value: _currentIntValue,
            minValue: minValue,
            maxValue: maxValue,
            onChanged: (value) {
              setState(() =>
                  _currentIntValue = value); // to change on widget level state
              setDialogState(
                  () => _currentIntValue = value); //* to change on dialog state
            });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // TEST START
    DateTime now = DateTime.now();
    for (int tYear = 2000; tYear <= 2013; tYear++) {
      for (int tMonth = 1; tMonth <= 12; tMonth++) {
        int lastday = DateTime(tYear, tMonth + 1, 0).day;
        if (tMonth == 2)
          print("${tYear}year's ${tMonth}month lastday: ${lastday}");
      }
    }

    // TEST END

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            ElevatedButton(
                onPressed: () {
                  _showIntegerDialog(context);
                },
                child: Text('show dialog numberpicker')),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
