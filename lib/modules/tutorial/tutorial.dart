import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Tutorial extends StatefulWidget {
  const Tutorial({super.key});

  @override
  State<Tutorial> createState() => _TutorialState();
}

class _TutorialState extends State<Tutorial> {
  @override
  void initState() {
    super.initState();
  }

  Future<void> _noShowAgain() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('tutorialDone', true);
    Navigator.pushReplacementNamed(context, "/menu");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 400, 
              child: Image.network(
                "https://placehold.co/600x400/red/white/png",
                width: double.infinity,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                 Navigator.pushNamed(context, "/menu", arguments: "tutorial");
              },
              child: const Text("Continuar"),
            ),
            InkWell(
              onTap: () {
                _noShowAgain();
              },
              child: const Text("No volver a mostrar"),
            ),
            const SizedBox(width: 16,)
          ],
        ),
      ),
    );
  }
}
