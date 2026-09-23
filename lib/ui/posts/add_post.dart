import 'package:firebase_database/firebase_database.dart';
import 'package:firebasepractice/utils/utils.dart';
import 'package:firebasepractice/widgets/round_button.dart';
import 'package:flutter/material.dart';

class AddPost extends StatefulWidget {


  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {

  bool loading = false;
  final postController = TextEditingController();
  final databaseRef = FirebaseDatabase.instance.ref('Post');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Post'),
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('Add Post Screen'),
              
              TextFormField(
                controller: postController,
                decoration: const InputDecoration(
                  hintText: 'Enter Post Title',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 8.0),

              RoundButton(title: 'Add' , onTap: () {
                loading = true;
                onTap: () {
                  setState(() {
                    loading = true;
                  });
                };

                String id = DateTime.now().millisecondsSinceEpoch.toString();
                databaseRef.child(id).set({
                  'title' : postController.text.toString(),
                  'id' : id,
                }).then((value) {
                  setState(() {
                    loading = false;
                    utils.toastMessage('Post Added');
                  });
                }).onError((error, stackTrace) {
                  setState(() {
                    loading = false;
                    utils.toastMessage(error.toString());
                  });
                });
              }),
            ],
          ),
        ),
      ),
    );
  }

  
}