
import 'package:edu_sys/src/users/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: const FirebaseOptions(
      apiKey: "AIzaSyDf3mTnr1o5VdR6QgoNlYTRZQuoT_Aef5g",
      appId: "1:505200240062:web:826bd45c63ba8ad85f85ef",
      messagingSenderId: "505200240062",
      projectId: "fir-firestore-b2890"));
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: RegisterScreen());
  }
}
