import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractice/ui/auth/verify_code.dart';
import 'package:firebasepractice/utils/utils.dart';
import 'package:firebasepractice/widgets/round_button.dart';
import 'package:flutter/material.dart';


class LoginWithPhone extends StatefulWidget {
  const LoginWithPhone({super.key});

  @override
  State<LoginWithPhone> createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {

  bool loading = false;
  final phoneController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login with Phone'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            const Text('Login with Phone'),
        
            TextFormField(
              controller: phoneController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: 'Enter your phone number',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),

            RoundButton(title: 'Login', loading: loading, onTap: (){
              setState(() {
                loading = true;
              });
              auth.verifyPhoneNumber(
                phoneNumber: phoneController.text,
                verificationCompleted: (_){
                    setState(() {
                      loading = false;
                    });
                  
                },
                verificationFailed: (e){
                  setState(() {
                    loading = false;
                  });
                 utils.toastMessage(e.toString());  
                  },
                  
                
                codeSent: (String verificationId, int? token){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) => VerifyCode(verificationId: verificationId) ));
                    setState(() {
                      loading = false;
                    });
                 
                },
                codeAutoRetrievalTimeout: (e){
                  utils.toastMessage(e.toString());
                  setState(() {
                      loading = false;
                    });
                });
            })

          ],
        ),
      ),
    );
  }
}