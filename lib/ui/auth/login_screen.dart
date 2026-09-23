import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractice/ui/auth/login_with_phone.dart';
import 'package:firebasepractice/ui/auth/signup_screen.dart';
import 'package:firebasepractice/ui/choice_screen.dart';
import 'package:firebasepractice/ui/posts/post_screen.dart';
import 'package:firebasepractice/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebasepractice/utils/utils.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();

  }

  void login(){
    setState(() {
      loading = true;
    });
    auth.signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text.toString()
    ).then((value){
     utils.toastMessage(value.user!.email.toString());
     Navigator.push(context, 
     MaterialPageRoute( builder: (context) => const ChoiceScreen()
     ));
     setState(() {
      loading = false;   
     });
    }).onError((error, stackTrace){
      debugPrint(error.toString());
       utils.toastMessage(error.toString());

       setState(() {
      loading = false;   
     });
    });

    
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop(); // Close the app when back button is pressed
        return false; // Prevent back navigation
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('Login Screen'),
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
              
              
      
      
      
              RoundButton(title: 'Login',
              loading: loading,
              onTap: (){
                if(_formKey.currentState!.validate()){
                  print('Email: ${emailController.text}');
                  print('Password: ${passwordController.text}');
                  login();
              };
              },
              ),
      
      
                const SizedBox(height: 50,),
      
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(onPressed: (){
                      Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) => const SignupScreen()
                      ));
                    }, child: const Text('Sign Up'))
                  ],
                ),

                const SizedBox(height: 30,),

                
      InkWell(
        onTap: (){
          Navigator.push(context, 
                      MaterialPageRoute(
                        builder: (context) =>  LoginWithPhone()));
        },
        child: Container(
        height: 50,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.deepPurpleAccent,
          border: Border.all(color: Colors.black, width: 2)
        ),
        child: Center(
          child: Text("login with phone"),)
      ) 
      )
            
            ]
          ),
        ),
      ),
    );
  }
}