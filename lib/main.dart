import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

TextEditingController _controller = TextEditingController();
// hier werden dei Variablen für Restzeit und aktivität gesetzt
int _remainingTime = 0;
bool _isactive = false;

// Methode zum Straten des Countdowns

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose(); // Den Controller freigeben
    super.dispose();
  }

  //--------------------------------------------------------------------
  void startCountdown() {
    //! in die inserted Time wird der inhalt des Textfieldes geschrieben
    int? insertedTime = int.tryParse(_controller.text);
    if (insertedTime != null && insertedTime > 0) {
// verbleibende Zeit wird aus die Zeit gestzt die eingegeben wurde und aktiv wird auf rtrue gesetzt
//! wichtig Set Stae immer im State Abschnitt setzen
      setState(() {
        _remainingTime = insertedTime;
        _isactive = true;
      });
// hier dei Methode _runCountdown aufrufen
      _runCountDown();
    } else {
      //hier wird die ausgelegerte Snackbar angezeigt
      _showSnackBar(" Bitte eine gültige Zeit eingeben");
    }
  }

//--------------------------------------------------------------------
  void _runCountDown() async {
    while (_remainingTime > 0 && _isactive) {
      await Future.delayed(const Duration(seconds: 1));

      setState(() {
        _remainingTime--;
      });
    }
    if (_remainingTime == 0) {
      _showSnackBar(" Time is Over");
    }
  }
//--------------------------------------------------------------------
void stopCountDown (){

setState(() {
  _isactive = false;
  _remainingTime = 0;
});}
//-------------------------------------------------------------------
void _showSnackBar (String nachricht){
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(nachricht)));
}
}
//------------------------------------------------------------------------


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: counterinput,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                    labelText: "Gib die Länge des Timers ein",
                    border: OutlineInputBorder()),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {}, child: const Text("Starte den Timer")),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Stoppe den Timer")),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Container(
              child: const Text("Hier wird die Restzeit angezeigt"),
            )
          ],
        ),
      ),
    ));
  }
}
