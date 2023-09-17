import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const  Text('Flutter FireBase'),
        actions:   [
          IconButton(onPressed: ()async{
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          }, icon: const  Icon(Icons.exit_to_app))
        ],
      ),
      body: ListView(
        children:   [
          FirebaseAuth.instance.currentUser!.emailVerified ? const  Center(child: Text("Welcome")):
          MaterialButton(
            textColor: Colors.white,
            color: Colors.blue,
            onPressed: (){
              FirebaseAuth.instance.currentUser!.sendEmailVerification() ;
            },
            child: const Text("please verifed your email") ,)
        ],
      ),
    );
  }
}