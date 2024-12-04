import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:quiz_app/Authenticate/adminlogin.dart';
import 'package:quiz_app/Authenticate/login.dart';
import 'package:quiz_app/Authenticate/register.dart';
import 'package:quiz_app/adminpannel.dart';
import 'package:quiz_app/home.dart';
import 'package:quiz_app/quiz.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/register': (context) => RegisterPage(),
        '/login': (context) => LoginPage(),
        '/adminLogin': (context) => AdminLoginPage(), // Add route for AdminLoginPage
        '/admin': (context) => AdminPage(),
        '/quiz': (context) => QuizPage(),
      },
    );
  }
}