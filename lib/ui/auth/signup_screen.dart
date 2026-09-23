import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractice/ui/auth/login_screen.dart';
import 'package:firebasepractice/utils/utils.dart';
import 'package:firebasepractice/widgets/round_button.dart';
import 'package:flutter/material.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void login(){
    setState(() {
                  loading = true;
                });
                auth.createUserWithEmailAndPassword(
                  email: emailController.text.toString(),
                  password: passwordController.text.toString()).then((value) {
                    
                    setState(() {
                      loading = false;
                    });
                    

                  }).onError((error, stackTrace) {
                     utils.toastMessage(error.toString());
                     setState(() {
                      loading = false;
                    });
                  });
  }
                
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Signup Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          
         
          


          children:[
            Form(
              key: _formKey,
              child: Column( 
                children:[
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'Email',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your email';
                }
                return null;
              }
            ),
            SizedBox(height: 10,),
            const SizedBox(height: 10,),

            TextFormField(
              keyboardType: TextInputType.text,
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                hintText: 'Password',
                border: OutlineInputBorder(),
              ),

              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              }
            ),

             
                ]
              )
              ),

              const SizedBox(height: 50,),
            
            



            RoundButton(title: 'signup',
            loading: loading,
            onTap: (){
              if(_formKey.currentState!.validate()){

                login();
                 }
            },
            ),


              const SizedBox(height: 50,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(onPressed: (){
                    Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen()
                    ));
                  }, child: const Text('Login'))
                ],
              )

          
          ]
        ),
      ),
    );
  }
}