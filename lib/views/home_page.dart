import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: (){
        
        Navigator.of(context).pushNamed('add');
      },
      child:const  Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const  Text('Flutter FireBase'),
        actions:   [
          IconButton(onPressed: ()async{
            GoogleSignIn googleSignIn =GoogleSignIn();
            googleSignIn.disconnect();
            await FirebaseAuth.instance.signOut();
            // ignore: use_build_context_synchronously
            Navigator.of(context).pushNamedAndRemoveUntil("login", (route) => false);
          }, icon: const  Icon(Icons.exit_to_app))
        ],
      ),
      body: GridView(
        gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 200),
        children:  [
          Card(  
            child:Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding:const  EdgeInsets.all(10),
                child: Column(
                  children: [
                  Image.asset("images/logo.png",height: 100,),
                 const  Text("Company")
                  ],
                ),
              ),
            )
             ,),
              Card(  
            child:Padding(
              padding: const EdgeInsets.all(15),
              child: Container(
                padding:const  EdgeInsets.all(10),
                child: Column(
                  children: [
                  Image.asset("images/logo.png",height: 100,),
                 const  Text("Company")
                  ],
                ),
              ),
            )
             ,)
          // FirebaseAuth.instance.currentUser!.emailVerified ? const  Center(child: Text("Welcome")):
          // MaterialButton(
          //   textColor: Colors.white,
          //   color: Colors.blue,
          //   onPressed: (){
          //     FirebaseAuth.instance.currentUser!.sendEmailVerification() ;
          //   },
          //   child: const Text("please verifed your email") ,)
        ],
      ),
    );
  }
}