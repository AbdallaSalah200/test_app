import 'package:flutter/material.dart';

class CustomTextFieldAdd extends StatelessWidget {
  const CustomTextFieldAdd({super.key, required this.text, required this.mycontroller,required this.validator});
final String  text ;
final TextEditingController mycontroller ;
 final String? Function(String?)? validator ;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
        controller: mycontroller ,
        decoration:  InputDecoration(
          
          hintText: text,
          hintStyle: const  TextStyle(
            color: Colors.grey
          ),
          filled: true,
          fillColor: Colors.grey[200],
          border:    OutlineInputBorder(
            borderSide :  const BorderSide(
              color:Color.fromARGB(255, 184, 184, 184),
              
            ),
            borderRadius: BorderRadius.circular(50)
          )
        ),
       );
  }
}