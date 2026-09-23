import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepractice/utils/utils.dart';
import 'package:firebasepractice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class Addfirestoredata extends StatefulWidget {

  @override
  State<Addfirestoredata> createState() => _AddfirestoredataState();
}

class _AddfirestoredataState extends State<Addfirestoredata> {

  bool loading = false;
  final postController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              TextFormField(
                controller: postController,
                decoration: const InputDecoration(
                  hintText: 'Enter Post Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8.0),

              RoundButton(
                title: 'Add',
                loading: loading,
                onTap: () {
                  if (postController.text.trim().isEmpty) {
                    utils.toastMessage('Please enter something');
                    return;
                  }

                  setState(() {
                    loading = true;
                  });

                  String id = DateTime.now().millisecondsSinceEpoch.toString();
                  fireStore.doc(id).set({
                    'title':  postController.text.toString(),
                    'id': id,
                  }).then((value){
                    setState(() {
                    loading = false;
                  });
                     utils.toastMessage('Post Added');
                  }).onError((error, stackTrace){
                    setState(() {
                    loading = false;
                  });
                    utils.toastMessage(error.toString());
                  });
                }
                
               
              ),
            ],
          ),
        ),
      ),
    );
  }

  
}
