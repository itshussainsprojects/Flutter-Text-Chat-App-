import 'package:firebase_core/firebase_core.dart';
import 'package:firebaselab/home.dart';
import 'package:flutter/material.dart';
import 'login.dart';
import 'firebaseoptions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Auth Demo',
        home: const Login(),
        routes: {
          '/home': (context) => const HomePage(),
        });
  }
}
