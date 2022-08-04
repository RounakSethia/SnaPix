import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixapp/Firebase/auth_methods.dart';
import 'package:pixapp/Pages/about.dart';
import 'package:pixapp/Pages/login.dart';
import 'package:pixapp/widgets/theme_widgets.dart';

class SettingPage extends StatefulWidget {
  String userid;
  SettingPage({Key? key,required this.userid}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var userData = {};
  // int postLength = 0;
  // int followers = 0;
  // int following = 0;
  // bool isuserFollowing = false;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    setState(() {
      loading = true;
    });
    try {
      var userSnap = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userid)
          .get();

    //   // get post lENGTH
    //   var postSnap = await FirebaseFirestore.instance
    //       .collection('posts')
    //       .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
    //       .get();

    //   postLength = postSnap.docs.length;
      userData = userSnap.data()!;
    //   followers = userSnap.data()!['followers'].length;
    //   following = userSnap.data()!['following'].length;
    //   isuserFollowing = userSnap
    //       .data()!['followers']
    //       .contains(FirebaseAuth.instance.currentUser!.uid);
    //   setState(() {});
    } catch (e) {
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColors(),
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: Icon(
            CupertinoIcons.back,
            color: themesSwitch ? Colors.white : Colors.black,
          ),
        ),
        title: Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text(
            'Settings',
            style: TextStyle(
              color: themesSwitch ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
      body: Container(
          color: themesSwitch ? Colors.black : Colors.white,
          padding: const EdgeInsets.all(8),
          child: ListView(
            children: [
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  ClipOval(
                    child: Material(
                      color: themesSwitch ? Colors.white : Colors.black,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => aboutPage(),
                          ),
                        ),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            CupertinoIcons.person_crop_circle,
                            size: 40,
                            color: themesSwitch ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ' ACCOUNT',
                    style: TextStyle(
                        color: themesSwitch ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                  const Divider(
                    height: 60,
                    thickness: 2,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text('Email: ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themesSwitch ? Colors.white : Colors.black,),),
                        
                        Text(userData['email'],style: TextStyle(color: themesSwitch ? Colors.white : Colors.black,),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text('Username: ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themesSwitch ? Colors.white : Colors.black,),),
                        Text(userData['username'],style: TextStyle(color: themesSwitch ? Colors.white : Colors.black,),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Text('Bio: ',style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: themesSwitch ? Colors.white : Colors.black,),),
                        
                        Text(userData['bio'],style: TextStyle(color: themesSwitch ? Colors.white : Colors.black,),),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  ClipOval(
                    child: Material(
                      color: themesSwitch ? Colors.white : Colors.black,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => aboutPage(),
                          ),
                        ),
                        child: SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            CupertinoIcons.person_2_square_stack_fill,
                            size: 40,
                            color: themesSwitch ? Colors.black : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    ' ABOUT',
                    style: TextStyle(
                        color: themesSwitch ? Colors.white : Colors.black,
                        fontSize: 20),
                  ),
                  const Divider(
                    height: 60,
                    thickness: 2,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(32),
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size(
                          250,
                          50,
                        ),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w900),
                        primary: themesSwitch ? Colors.white : Colors.black,
                        side: BorderSide(
                          width: 1,
                          color: themesSwitch ? Colors.white : Colors.black,
                        ),
                      ),
                      onPressed: () async {
                        await AuthMethods().signOut();
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const LoginPage(),
                          ),
                        );
                      },
                      child: Text(
                        'SIGN OUT',
                        style: TextStyle(
                          color: themesSwitch ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 60,
                    thickness: 2,
                    color: themesSwitch ? Colors.white : Colors.black,
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
