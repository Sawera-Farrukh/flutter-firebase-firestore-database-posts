import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebasepractice/ui/auth/login_screen.dart';
import 'package:firebasepractice/ui/posts/add_post.dart';
import 'package:firebasepractice/utils/utils.dart';
import 'package:flutter/material.dart';



class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('Post');
  final searchFilter = TextEditingController();
  final editController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Fire base Post Screen'),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: TextFormField(
              controller: searchFilter,
              decoration: const InputDecoration(
                hintText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
                )
              ),
              onChanged: (String value){
                setState(() {
                  
                });
              },
            ),
          ),
          Expanded(
            child: FirebaseAnimatedList(
              query: ref,
              defaultChild:  Text('Loading'),
              itemBuilder: (context, snapshot, animation, index){
                final title = snapshot.child('title').value.toString();
                
             if (searchFilter.text.isEmpty){
                  return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString()),
                  trailing: PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            ref.child(snapshot.child('id').value.toString()).remove();
                          },
                          leading: Icon(Icons.delete),
                          title: Text('Delete'),
                        )
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: ListTile(
                          onTap: (){
                            Navigator.pop(context);
                            showMyDialog(title , snapshot.child('id').value.toString());
                          },
                          leading: Icon(Icons.edit),
                          title: Text('Edit'),
                        )
                      )
                    ],



                  ),
                );
             }else if(title.toLowerCase().contains(searchFilter.text.toLowerCase())){
                return ListTile(
                  title: Text(snapshot.child('title').value.toString()),
                  subtitle: Text(snapshot.child('id').value.toString())
                );}

                else{
                  
                  return Container();
                }




               
              },
            ),
          )
          ],
      ),
     floatingActionButton: FloatingActionButton(
      onPressed: (){
        auth.signOut().then((value){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>const AddPost()));
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
                ref.child(id).update({
                  'title': editController.text.toLowerCase()
                }).then((value){
                  utils.toastMessage('Post Updated');
                }).onError((error, stackTrace){
                  utils.toastMessage(error.toString());
                });
              }, child: Text('update')),
              TextButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text('Cancel')),
            ],
        );
      }
    );
  }
}


















//  Expanded(child: StreamBuilder(
//             stream: ref.onValue,
//             builder: (context, AsyncSnapshot<DatabaseEvent> snapshot){
//               if(!snapshot.hasData){
//                 return CircularProgressIndicator();

//               }else{
//                 Map<dynamic, dynamic> map = snapshot.data!.snapshot.value as dynamic;
//                 List<dynamic> list = [];
//                 list.clear();
//                 list = map.values.toList();  

//                 return ListView.builder(
//                 itemCount: snapshot.data!.snapshot.children.length,
//                 itemBuilder: (context, index){
//                   return ListTile(
//                     title: Text(list[index]['title']),
//                     subtitle: Text(list[index]['id'])
//                   );
//                 },);
//               } },
//             )),