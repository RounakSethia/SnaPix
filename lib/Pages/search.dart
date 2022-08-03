import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixapp/Pages/profile.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUsers = false;
  String username = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration: const InputDecoration(
              labelText: 'Search for a user...',
              prefixIcon: Icon(
                CupertinoIcons.search,
              ),  
            ),
            onChanged: (val) {
              setState(() {
                username = val;
              });
            },
          ),
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: (username != " " && username != null)
              ? FirebaseFirestore.instance
                  .collection('users')
                  .where('username',
                      isGreaterThanOrEqualTo: searchController.text)
                  .snapshots()
              : FirebaseFirestore.instance.collection('users').snapshots(),
          builder: (context, snapshot) {
            return (snapshot.connectionState == ConnectionState.waiting)
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      DocumentSnapshot data = snapshot.data!.docs[index];
                      return InkWell(
                        child: Container(
                          padding: EdgeInsets.only(top: 16),
                          child: Column(
                            children: [
                              ListTile(
                                title: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => ProfilePage(
                                        userid: (snapshot.data! as dynamic)
                                            .docs[index]['uid'],
                                      ),
                                    ),
                                  ),
                                  child: Text(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['username'],
                                  ),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    (snapshot.data! as dynamic).docs[index]
                                        ['photoUrl'],
                                  ),
                                  radius: 30,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    });
          }),
    );
  }
}
