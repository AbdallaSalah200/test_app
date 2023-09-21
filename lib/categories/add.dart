import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercourse/widgets/custom_button.dart';
import 'package:fluttercourse/widgets/custom_text_field_add.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
 GlobalKey<FormState> formstate =GlobalKey<FormState>();
 TextEditingController name =TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  bool isLoading = false ;
  addCategoris ()async{
if (formstate.currentState!.validate()) {
  try {
    isLoading =true ;
    setState(() {
      
    });
  DocumentReference response =    await  categories.add({
        "name":name.text,
        "id": FirebaseAuth.instance.currentUser!.uid//لمعرفة id خاصة بمستخدم
      });
      Navigator.of(context).pushNamedAndRemoveUntil("homepage",(route)=> false);
} catch (e) {
  isLoading=false;
  setState(() {
    
  });
  print("Error$e");
}
}
  }
   
    //  Future<void> addUser() {
    //   // Call the user's CollectionReference to add a new user
    //   return categories
    //       .add({
    //        "name":name.text
    //       })
    //       .then((value) => print("User Added"))
    //       .catchError((error) => print("Failed to add user: $error"));
    // }
      @override
     void dispose() {
    super.dispose();
    name.text;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const  Text("AddCategory"),
      ),
     body: Form(
      key:formstate ,
       child:   isLoading ?const  Center(child: CircularProgressIndicator(),) : Column(
         children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            child: CustomTextFieldAdd(text: "Enter Name", mycontroller: name, validator: (val){
                if(val ==""){
                  return"Please enter name";
                }
            }),
          ),
          CustomButton(onpressed: (){
            addCategoris();
         //   addUser();
          }, title: "Add",
          
          )
         ],    
       ),
     ),
    );
  }
}