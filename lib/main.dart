import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fluttercourse/categories/add.dart';
import 'package:fluttercourse/views/home_page.dart';
import 'package:fluttercourse/views/auth/login.dart';
import 'package:fluttercourse/views/auth/sign_up.dart';
//import 'package:test_app/views/home_page.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const TestAPP());
}

class TestAPP extends StatefulWidget {
  const TestAPP({super.key});

  @override
  State<TestAPP> createState() => _TestAPPState();
}

class _TestAPPState extends State<TestAPP> {
  @override
  void initState() {
FirebaseAuth.instance
  .authStateChanges()
  .listen((User? user) {
    if (user == null) {
      print('User is currently signed out!');
    } else {
      print('User is signed in!');
    }
  });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
     // themeMode: ThemeMode.light,
     theme: ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[50],
      titleTextStyle:const  TextStyle(
        color: Colors.orange,
        fontSize: 17,
        fontWeight: FontWeight.bold
      ),
      iconTheme:  const  IconThemeData(
        color: Colors.orange
      )
    )
     ),
      debugShowCheckedModeBanner: false,
      home:const HomePage(),
      // (FirebaseAuth.instance.currentUser !=null&&FirebaseAuth.instance.currentUser!.emailVerified )? const  HomePage():const  Login(),
      routes: {
        "login":(context) => const Login(),
        "signup":(context) => const SignUp(),
         "homepage":(context) => const HomePage(),
         "add":(context) => const Add()
      },
    );
  }
}
