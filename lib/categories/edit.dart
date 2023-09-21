import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fluttercourse/widgets/custom_button.dart';
import 'package:fluttercourse/widgets/custom_text_field_add.dart';

class Edit extends StatefulWidget {
  final String docid;
  final String oldname;
  const Edit({super.key, required this.docid, required this.oldname});

  @override
  State<Edit> createState() => _EditState();
}

class _EditState extends State<Edit> {
 GlobalKey<FormState> formstate =GlobalKey<FormState>();
 TextEditingController name =TextEditingController();
  CollectionReference categories = FirebaseFirestore.instance.collection('categories');
  bool isLoading = false ;
  editategoris ()async{
if (formstate.currentState!.validate()) {
  try {
    isLoading =true ;
    setState(() {
      
    });
   await  categories.doc(widget.docid).update({
    "name": name.text
   } );
      Navigator.of(context).pushNamedAndRemoveUntil("homepage",(route)=> false);
} catch (e) {
  isLoading=false;
  setState(() {
    
  });
  print("Error$e");
}
}
  }
  @override
  void initState() {
    super.initState();
    name.text =widget.oldname;
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
             editategoris();
         //   addUser();
          }, title: "Add",
          
          )
         ],    
       ),
     ),
    );
  }
}