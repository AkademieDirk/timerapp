import 'package:flutter/material.dart';

class SimpleTimerApp extends StatefulWidget {
  const SimpleTimerApp({super.key});

  @override
  State<SimpleTimerApp> createState() => _SimpleTimerAppState();
}

class _SimpleTimerAppState extends State<SimpleTimerApp> {
  final TextEditingController _controller = TextEditingController();
  int _remainingTime = 0;
  bool _isactive = false;

  // Methode zum Starten des Countdowns
  void _startTimer() {
    int? insertedTime = int.tryParse(_controller.text);
    if (insertedTime != null && insertedTime > 0) {
      setState(() {
        _remainingTime = insertedTime;
        _isactive = true;
      });
      _runCountDown();
    } else {
      _showSnackBar("Bitte eine gültige Zeit eingeben");
    }
  }

  // Methode für den Countdown
  void _runCountDown() async {
    while (_remainingTime > 0 && _isactive) {
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _remainingTime--;
      });
    }
    if (_remainingTime == 0) {
      _showSnackBar("Time is Over");
    }
  }

  // Methode zum Stoppen des Countdowns
  void _stopCountDown() {
    setState(() {
      _isactive = false;
      _remainingTime = 0;
    });
  }
  // Methode zum Clearen  der eingegebenen Zahl wenn gestoppt

  void _clearCountDown() {
    setState(() {
      _isactive = false;
      _controller.text = "";
      _remainingTime = 0;
    });
  }

  // Snackbar anzeigen
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        textAlign: TextAlign.center,
        message,
        style: const TextStyle(color: Colors.black, fontSize: 24),
      ),
      backgroundColor: Colors.red,
    ));
  }

  // Aufräumen beim Verlassen der Seite
  //! ist es wichtig wo das dispose steht?
  @override
  void dispose() {
    _controller.dispose(); // Controller freigeben
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Einfacher Timer'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Gib die Länge des Timers ein",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _isactive
                      ? null
                      : _startTimer, // Button deaktivieren, wenn aktiv
                  child: const Text("Starte den Timer"),
                ),
                ElevatedButton(
                  onPressed: _isactive
                      ? _stopCountDown
                      : null, // Stoppen nur wenn aktiv
                  child: const Text("Stoppe den Timer"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                _isactive ? null : _clearCountDown();
              },
              // _isactive ? _stopCountDown : null, // Stoppen nur wenn aktiv
              child: const Text("Lösche die Zeiteingabe"),
            ),
            const SizedBox(height: 100),
            Text(
              "Die Restzeit ist: $_remainingTime",
              style: const TextStyle(fontSize: 24),
            ),
          ],
        ),
      ),
    );
  }
}
