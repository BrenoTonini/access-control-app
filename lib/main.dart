import 'package:flutter/material.dart';
import 'dart:math';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color _randomColor = const Color.fromARGB(255, 255, 0, 0);

  void _changeColor() {
    Random rnd = Random();
    setState(() {
      _randomColor = Color.fromRGBO(
        rnd.nextInt(256),
        rnd.nextInt(256),
        rnd.nextInt(256),
        1.0,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Controle de Acesso',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: _randomColor),
      ),
      home: MyHomePage(
        title: 'Controle de Acesso',
        changeColor: _changeColor,
        randomColor: _randomColor,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
    required this.changeColor,
    required this.randomColor,
  });

  final String title;
  final VoidCallback changeColor;
  final Color randomColor;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final int _maxPeople = 10;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startAutoDecrement() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          if (_counter > 0) {
            _counter--;
          }

        
          if (_counter < 10) {
            _timer?.cancel();
          }
        });
      }
    });
  }

  void _incrementCounter() {
    setState(() {
      if (_counter < 15) {
        _counter++;

    
        if (_counter == 10) {
          _startAutoDecrement();
        }
      }
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter > 0) {
        _counter--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.randomColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          if (_counter >= _maxPeople)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Theme.of(context).colorScheme.error,
              child: const Text(
                'Limite de pessoas atingido, aguarde...',
                style: TextStyle(color: Colors.white, fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Número de pessoas no ambiente:', style: TextStyle(fontSize: 15)),
                  Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: _decrementCounter,
                        child: const Icon(Icons.remove),
                      ),
                      const SizedBox(width: 20),
                      ElevatedButton(
                        onPressed: _incrementCounter,
                        child: const Icon(Icons.add),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: widget.changeColor,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: widget.randomColor,
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    ),
                    child: const Text(
                      'Mudar Cor',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}