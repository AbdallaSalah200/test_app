import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:fluttercourse/widgets/custom_logo.dart';
import 'package:fluttercourse/widgets/custom_button.dart';
import 'package:fluttercourse/widgets/custom_text_field.dart';
class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
   TextEditingController uesrName =TextEditingController();
  TextEditingController email =TextEditingController();
   TextEditingController password =TextEditingController();
    GlobalKey<FormState> formstate =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:  const EdgeInsets.all(20),
      child: Form(
        key :formstate,
        child: ListView(children: [
         const  CustomLogo(imagelogo: 'images/logo.png'),
         const  SizedBox(height: 20,),
         const     Text('Register ', style: TextStyle(
          fontSize: 25,fontWeight: FontWeight.bold
         ),),
            const  SizedBox(height: 10,),
         const     Text('Register to contiue using app ', style: TextStyle(
          fontSize: 14,color: Colors.grey
         ),),
         const SizedBox(
          height: 20,
         ),
          const   Text('UesrName',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
           ),),
        const SizedBox(
          height: 10,
         ),
         CustomTextField(text: 'Enter your UserName', mycontroller: uesrName
         , validator: (val){
          if(val == ""){
            return "cant be empty";
          }
         },
         ),
           const   Text('Email',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
           ),),
        const SizedBox(
          height: 10,
         ),
         CustomTextField(text: 'Enter your Email', mycontroller: email,
          validator: (val){
          if(val == ""){
            return "cant be empty";
          }
         },
         ) ,
          const SizedBox(
          height: 10,
         ),
        const   Text('password',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
           ),),
           const SizedBox(
          height: 10,
           ),
          
         CustomTextField(text: 'Enter your Password', mycontroller: password,
          validator: (val){
          if(val == ""){
            return "cant be empty";
          }
         },
         ) ,
        const  Padding(
           padding:  EdgeInsets.only(top: 10,bottom: 20),
           child: Text("Forget Password ?",style: TextStyle(
            fontSize: 18,
            
           ),
           textAlign: TextAlign.right,
           ),
         ),
          const SizedBox(
          height: 20,
           ),
           CustomButton(title: 'Register',onpressed: ()
          async {
        if (formstate.currentState!.validate()) {
  try {
  final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
    email: email.text,
    password: password.text,
  );
  
  Navigator.of(context).pushReplacementNamed("homepage");

        } on FirebaseAuthException catch (e) {
  if (e.code == 'weak-password') {
    print('The password provided is too weak.');
     // ignore: use_build_context_synchronously
     AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'The password provided is too weak.',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
        ).show();
  } else if (e.code == 'email-already-in-use') {
    print('The account already exists for that email.');
     // ignore: use_build_context_synchronously
     AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'The account already exists for that email',
        btnCancelOnPress: () {},
        btnOkOnPress: () {},
        ).show();
  }
        } catch (e) {
  print(e);
        }
}
           },),
        const SizedBox(
          height:20,),
           MaterialButton(onPressed: (){},
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(70),
        
        ),
        color: Colors.red[600],
        textColor: Colors.white,
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           const  Text('Login   ',),
      
            Image.asset('images/4.png',width: 20,)
          ],
        ),
        ),
        const SizedBox(height:20,),
         InkWell(
          onTap:(){
        Navigator.of(context).pop();
          },
           child: const  Center(
          child:   Text.rich(TextSpan(children: [
              TextSpan(text: 'Don t have an accont ? ',style: TextStyle(fontSize: 16)),
               TextSpan(text: 'Login',style: TextStyle(
              color:Colors. orange,fontSize: 18
               ) )
            ])),
        ),
         )
        ]
        ),
      ),
      ),
    );
  }
}