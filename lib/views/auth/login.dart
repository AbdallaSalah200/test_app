import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:fluttercourse/widgets/custom_logo.dart';
import 'package:fluttercourse/widgets/custom_button.dart';
import 'package:fluttercourse/widgets/custom_text_field.dart';
class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email =TextEditingController();
   TextEditingController password =TextEditingController();
   GlobalKey<FormState> formstate =GlobalKey<FormState>();
   
Future signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
if (googleUser ==null){
  return ;
}
  // Obtain the auth details from the request
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  // Once signed in, return the UserCredential
  await FirebaseAuth.instance.signInWithCredential(credential);
   Navigator.of(context).pushNamedAndRemoveUntil("homepage", (route) => false);
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding:  const EdgeInsets.all(20),
      child: Form(
        key: formstate,
        child: ListView(children: [
         const  CustomLogo(imagelogo: 'images/logo.png'),
         const  SizedBox(height: 20,),
         const     Text('Login ', style: TextStyle(
          fontSize: 25,fontWeight: FontWeight.bold
         ),),
            const  SizedBox(height: 10,),
         const     Text('Login to contiue using app ', style: TextStyle(
          fontSize: 14,color: Colors.grey
         ),),
         const SizedBox(
          height: 20,
         ),
           const   Text('Email',style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20
           ),),
        const SizedBox(
          height: 10,
         ),
         CustomTextField(text: 'Enter your Email', mycontroller: email
        , validator: (val){
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
          
         CustomTextField(text: 'Enter your Password', mycontroller: password
         , validator: (val){
          if(val == ""){
            return "cant be empty";
          }
         },
         ) ,
        Padding(
           padding: const  EdgeInsets.only(top: 10,bottom: 20),
           child: InkWell(
            onTap: (){
              if (email.text== ""){
         AwesomeDialog(
          
        context: context,
        dialogType: DialogType.success,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'الرجاء ملئ الحقل ',
        ).show();
                return;
              }
           try {
  FirebaseAuth.instance.sendPasswordResetEmail(email: email.text);
}  catch (e) {
  AwesomeDialog(
          
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'الرجاء ادخال بريد الكتروني صحيح',
        ).show();
}
           AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'الرجاء التوجه علي بريدك الالكتروني لقد عملنا اعادة ارسال لكلمة مرور',
        ).show();
            },
             child: const  Text("Forget Password ?",style: TextStyle(
              fontSize: 18,
              
             ),
             textAlign: TextAlign.right,
             ),
           ),
         ),
          const SizedBox(
          height: 20,
           ),
           CustomButton(title: 'Login',onpressed: ()async{
      if (formstate.currentState!.validate()) {
  try {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email.text,
      password: password.text
    );
    if (credential.user!.emailVerified) {
  // ignore: use_build_context_synchronously
  Navigator.of(context).pushReplacementNamed("homepage");
}else {
  FirebaseAuth.instance.currentUser!.sendEmailVerification();  // ignore: use_build_context_synchronously
   // ignore: use_build_context_synchronously
   AwesomeDialog(
        context: context,
        dialogType: DialogType.error,
        animType: AnimType.rightSlide,
        title: 'Dialog Title',
        desc: 'الرجاء التوجه علي بريدك الالكتروني وتحقق منه',
        ).show();
}
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
    //  print('No user found for that email.');
      // ignore: use_build_context_synchronously
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'No user found for that email.',
         
          ).show();
    } else if (e.code == 'wrong-password') {
      //print('Wrong password provided for that user.');
      // ignore: use_build_context_synchronously
      AwesomeDialog(
          context: context,
          dialogType: DialogType.error,
          animType: AnimType.rightSlide,
          title: 'Dialog Title',
          desc: 'wrong-password',
        
          ).show();
    }
  }
}
      
           },),
        const SizedBox(
          height:20,),
           MaterialButton(onPressed: ()
           {
            signInWithGoogle();
           },
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
        Navigator.of(context).pushNamed('signup');
          },
           child: const  Center(
          child:   Text.rich(TextSpan(children: [
              TextSpan(text: 'Don t have an accont ? ',style: TextStyle(fontSize: 16)),
               TextSpan(text: 'Register',style: TextStyle(
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