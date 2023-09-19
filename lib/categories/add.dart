import 'package:flutter/material.dart';
import 'package:fluttercourse/widgets/custom_button.dart';
import 'package:fluttercourse/widgets/custom_text_field_add.dart';

class Add extends StatefulWidget {
  const Add({super.key});

  @override
  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
 GlobalKey<FormState> formstate =GlobalKey<FormState>();
 TextEditingController controller =TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AddCategory"),
      ),
     body: Form(
      key:formstate ,
       child: Column(
         children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 25),
            child: CustomTextFieldAdd(text: "Enter Name", mycontroller: controller, validator: (val){
                if(val ==""){
                  return"Please enter name";
                }
            }),
          ),
          CustomButton(onpressed: (){
            
          }, title: "Add",
          
          )
         ],    
       ),
     ),
    );
  }
}