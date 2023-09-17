import 'package:flutter/material.dart';

class CustomLogo extends StatelessWidget {
  const CustomLogo({super.key, required this.imagelogo});
     final String imagelogo ;
  @override
  Widget build(BuildContext context) {
    return  Column(
          children: [
         const   SizedBox(height: 50,),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(70),
              ),
              height: 80,
              width: 80,
             
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Image.asset(imagelogo,height: 40,width: 40,),
              ),
            ),
          ],
        );
  }
}