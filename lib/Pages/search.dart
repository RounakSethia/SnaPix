import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixapp/Pages/home.dart';
import 'package:pixapp/Pages/profile.dart';
import 'package:pixapp/widgets/theme_widgets.dart';

// Search for users and also shows a some extra users
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
      backgroundColor: themesSwitch?Colors.black: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: themeColors(),
        leading: IconButton(
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
          ),
          icon: Icon(
            CupertinoIcons.back,
            color: themesSwitch?Colors.white: Colors.black,
          ),
        ),
        title: Form(
          child: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search for a user...',
              labelStyle:
                  TextStyle(color: themesSwitch ? Colors.white : Colors.black),
              suffixIcon: Icon(
                CupertinoIcons.search,
                color: themesSwitch ? Colors.white : Colors.black,
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
                                    style: TextStyle(
                                      color: themesSwitch
                                          ? Colors.white
                                          : Colors.black,
                                    ),
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
