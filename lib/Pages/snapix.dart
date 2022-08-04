import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pixapp/widgets/post_widgets.dart';

//Displays users post on the home page by getting data from firebase
class SnapixPage extends StatefulWidget {
  const SnapixPage({Key? key}) : super(key: key);

  @override
  State<SnapixPage> createState() => _SnapixPageState();
}

class _SnapixPageState extends State<SnapixPage> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: StreamBuilder(
        
        stream: FirebaseFirestore.instance.collection('posts').snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              
              child: CircularProgressIndicator(),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => 
            PostSnapix(
              output: snapshot.data!.docs[index].data(),
            ),
          );
        },
      ),
    );
  }
}