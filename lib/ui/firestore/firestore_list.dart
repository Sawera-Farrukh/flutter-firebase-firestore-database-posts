import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasepractice/ui/auth/login_screen.dart';
import 'package:firebasepractice/ui/firestore/addfirestoredata.dart';
import 'package:firebasepractice/ui/posts/add_post.dart';
import 'package:firebasepractice/utils/utils.dart';
import 'package:flutter/material.dart';

class FirestoreList extends StatefulWidget {
  const FirestoreList({super.key});

  @override
  State<FirestoreList> createState() => _FirestoreListState();
}

class _FirestoreListState extends State<FirestoreList> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final fireStore = FirebaseFirestore.instance.collection('users').snapshots();
  final ref = FirebaseFirestore.instance.collection('users');


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fire store Post Screen'),
        // Back Arrow Button
   leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        
        actions: [
          IconButton(onPressed: (){
            auth.signOut().then((value){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
            }).onError((error, stackTrace){
              utils.toastMessage(error.toString());
            });

          }, icon: const Icon(Icons.logout_outlined))
        ],
      ),

      body:  Column(
        children: [
          StreamBuilder<QuerySnapshot>(
            stream: fireStore,
            builder: (BuildContext_context, AsyncSnapshot<QuerySnapshot> snapshot){
              if(snapshot.connectionState == ConnectionState.waiting)
                return CircularProgressIndicator();

                if(snapshot.hasError)
                  return Text('Some error occurred');
                
              


            return  Expanded(
            child: ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index){
              return ListTile(
                onTap:(){
                  ref.doc(snapshot.data!.docs[index]['id'].toString()).update({
                    'title': editController.text.toString()
                  }).then((value){
                    utils.toastMessage('Updated');
                  }).onError((error, stackTrace){
                    utils.toastMessage(error.toString());
                  });

                  ref.doc(snapshot.data!.docs[index]['id'].toString()).delete().then((value){
                    utils.toastMessage('Deleted');
                  }).onError((error, stackTrace){
                    utils.toastMessage(error.toString());
                  });
                },


                title: Text(snapshot.data!.docs[index]['title'].toString()),
                subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
              );
            })
          );
            
            },
          ),
          
          ],
      ),
     floatingActionButton: FloatingActionButton(
      onPressed: (){
        auth.signOut().then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>  Addfirestoredata()));
        });
      },
      child: Icon(Icons.add),
     ),
    );
  }
  

  Future<void> showMyDialog(String title, String id)async{
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('update'),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(
                hintText: 'Edit'
              ),
            ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
                
              }, child: Text('cancel')),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('update')),
            ],
        );
      }
    );
  }
}