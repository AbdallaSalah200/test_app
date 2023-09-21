import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttercourse/categories/edit.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercourse/constant/constant.dart';



class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<QueryDocumentSnapshot> data =[];
  bool  isLoading = true ;
  getdata()async{
  QuerySnapshot querySnapshot =  await FirebaseFirestore.instance
  .collection('categories').where("id",isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  data.addAll(querySnapshot.docs);
  isLoading =false;
  setState(() {
    
  });
  } 
  @override
  void initState() {
   getdata();
    super.initState();
  }
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
      body: isLoading ?const  Center(child: CircularProgressIndicator()):  GridView.builder(
          itemCount: data.length,
        gridDelegate: const  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,mainAxisExtent: 200),
   itemBuilder: (context, i) {
     return  InkWell(
      onLongPress: (){
          AwesomeDialog(
          
        context: context,
        dialogType: DialogType.warning,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: "أختر ماذا تريد",
        btnCancelText: "'حذف'",
        btnOkText: "تعديل ",
        btnCancelOnPress: () 
       async {
            await FirebaseFirestore.instance
  .collection('categories').doc(data[i].id).delete();
  Navigator.of(context).pushReplacementNamed("homepage");
        },
        btnOkOnPress: (){
  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> Edit(docid: data[i].id, oldname: data[i]["name"])));
        }
        ).show();
      },
       child: Card(  
              child:Container(
                padding:const  EdgeInsets.all(10),
                child: Column(
                  children: [
                  Image.asset(kImage,height: 100,),
                Text("${data[i]["name"]}")
                  ],
                ),
              )
               ,),
     );
   },
          // Card(  
          //   child:Container(
          //     padding:const  EdgeInsets.all(10),
          //     child: Column(
          //       children: [
          //       Image.asset(kImage,height: 100,),
          //      const  Text("Company")
          //       ],
          //     ),
          //   )
          //    ,),
            //   Card(  
            // child:Padding(
            //   padding: const EdgeInsets.all(15),
            //   child: Container(
            //     padding:const  EdgeInsets.all(10),
            //     child: Column(
            //       children: [
            //       Image.asset(kImage,height: 100,),
            //      const  Text("home")
            //       ],
            //     ),
            //   ),
            // )
            //  ,)
          // FirebaseAuth.instance.currentUser!.emailVerified ? const  Center(child: Text("Welcome")):
          // MaterialButton(
          //   textColor: Colors.white,
          //   color: Colors.blue,
          //   onPressed: (){
          //     FirebaseAuth.instance.currentUser!.sendEmailVerification() ;
          //   },
          //   child: const Text("please verifed your email") ,)
       
      ),
    );
  }
}