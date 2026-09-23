import 'package:firebasepractice/ui/posts/post_screen.dart';
import 'package:firebasepractice/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractice/utils/utils.dart';

class VerifyCode extends StatefulWidget {
  final String verificationId;
  const VerifyCode({super.key , required this.verificationId});

  @override
  State<VerifyCode> createState() => _VerifyCodeState();
}

class _VerifyCodeState extends State<VerifyCode> {
  bool loading = false;
  final verificationCodeController = TextEditingController();
  final auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('verify Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            SizedBox(height: 20,),
            const Text('Login with Phone'),
        
            TextFormField(
              controller: verificationCodeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: '6 digit code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20,),

            RoundButton(title: 'verify', loading: loading, onTap: ()async{
              setState(() {
                loading = true;
              });
              final credential = PhoneAuthProvider.credential(
                verificationId: widget.verificationId,
                smsCode: verificationCodeController.text.toString()
              );
              try{
                await auth.signInWithCredential(credential);

                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => const PostScreen()
                ));
              }catch(e){
                setState(() {
                loading = false;
                });
                utils.toastMessage(e.toString());
              }
             
            })

          ],
        ),
      ),
    );
  }
}