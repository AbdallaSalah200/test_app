import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.onpressed, required this.title});
final void Function() onpressed ;
final String title ;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
     // width: double.negativeInfinity,
     width: 100,
      child: MaterialButton(onPressed: onpressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70),
        
        ),
        color: Colors.orange,
        textColor: Colors.white,
        height: 50,
        minWidth: double.minPositive,
        child:   Center(
         child: Text(title,),
       ),
        ),
    );
  }
}