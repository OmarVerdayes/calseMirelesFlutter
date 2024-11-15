import 'package:flutter/material.dart';
import 'package:learning_b/modules/auth/screens/login.dart';
import 'package:learning_b/modules/auth/screens/create_account.dart';
import 'package:learning_b/modules/tutorial/tutorial.dart';
import 'package:learning_b/navigation/home.dart';
import 'package:learning_b/navigation/navigation.dart';
import 'package:learning_b/navigation/profile.dart';
import 'package:learning_b/navigation/reservations.dart';
import 'package:learning_b/navigation/top.dart';
import 'package:learning_b/widgets/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/menu': (context) => const navigation(),
        '/home': (context) => const home(),
        '/profile': (context) => const profile(),
        '/reservations': (context) => const reservations(),
        '/top': (context) => const top(),
        '/login': (context) => const Login(),
        '/register': (context) => const CreateAccount(),
        '/tutorial': (context) => const Tutorial(),
      },
    );
  }
}
