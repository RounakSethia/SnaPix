import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixapp/FIrebase/auth_methods.dart';
import 'package:pixapp/Firebase/firestore_methods.dart';
import 'package:pixapp/Pages/edit_profile.dart';
import 'package:pixapp/Pages/login.dart';
import 'package:pixapp/Pages/settings.dart';
import 'package:pixapp/Pages/snapix.dart';
import 'package:pixapp/widgets/theme_widgets.dart';

class ProfilePage extends StatefulWidget {
  String userid;
  ProfilePage({Key? key, required this.userid}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isuserFollowing = false;
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

      // get post lENGTH
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get();

      postLength = postSnap.docs.length;
      userData = userSnap.data()!;
      followers = userSnap.data()!['followers'].length;
      following = userSnap.data()!['following'].length;
      isuserFollowing = userSnap
          .data()!['followers']
          .contains(FirebaseAuth.instance.currentUser!.uid);
      setState(() {});
    } catch (e) {
      showSnackBar(
        context,
        e.toString(),
      );
    }
    setState(() {
      loading = false;
    });
  }

  Column userinfo(int value) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            color: themesSwitch?Colors.white: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: themeColors(),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 38.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: NetworkImage(
                          userData['photoUrl'],
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 70.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipOval(
                          child: Material(
                            color: themesSwitch?Colors.white: Colors.black,
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SnapixPage(),
                                ),
                              ),
                              child: const SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  CupertinoIcons.back,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: Colors.blue,
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => EditProfilePage(userid: FirebaseAuth.instance.currentUser!.uid,),
                                ),
                              ),
                              child: const SizedBox(
                                width: 80,
                                height: 80,
                                child: Icon(
                                  CupertinoIcons.pen,
                                  color: Colors.black,
                                  size: 55,
                                ),
                              ),
                            ),
                          ),
                        ),
                        ClipOval(
                          child: Material(
                            color: themesSwitch?Colors.white: Colors.black,
                            child: InkWell(
                              onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SettingPage(userid: FirebaseAuth.instance.currentUser!.uid,),
                                ),
                              ),
                              child: const SizedBox(
                                width: 50,
                                height: 50,
                                child: Icon(
                                  CupertinoIcons.settings,
                                  color: Colors.blue,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                userData['username'],
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    color: themesSwitch?Colors.white: Colors.black,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                userData['bio'],
                style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(
                    color: themesSwitch?Colors.white: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: Column(
              
              children: [
                
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        userinfo(
                          postLength,
                        ),
                        Text('Snapix',style: TextStyle(color: themesSwitch?Colors.white: Colors.black,),),
                        const SizedBox(height: 5),
                      ],
                    ),
                    Container(
                      color: themesSwitch?Colors.white: Colors.black,
                      width: 1,
                      height: 35,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        userinfo(
                          followers,
                        ),
                        Text('Followers',style: TextStyle(color: themesSwitch?Colors.white: Colors.black,),),
                        const SizedBox(height: 5),
                      ],
                    ),
                    Container(
                      color: themesSwitch?Colors.white: Colors.black,
                      width: 1,
                      height: 35,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 15,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        userinfo(
                          following,
                          
                        ),
                        Text('Following',style: TextStyle(color: themesSwitch?Colors.white: Colors.black,),),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              FirebaseAuth.instance.currentUser!.uid == widget.userid
                  ? Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: Size(
                            250,
                            50,
                          ),
                          textStyle: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w900),
                          primary: themesSwitch?Colors.white: Colors.black,
                          side: BorderSide(
                            width: 1,
                            color: themesSwitch?Colors.white: Colors.black,
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
                        child: Text('SIGN OUT'),
                      ),
                    )
                  : isuserFollowing
                      ? Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(32),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                250,
                                50,
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              primary: Colors.red,
                              onPrimary: Colors.black,
                            ),
                            onPressed: () async {
                              await FireStoreMethods().followUser(
                                FirebaseAuth.instance.currentUser!.uid,
                                userData['uid'],
                              );

                              setState(() {
                                isuserFollowing = false;
                                followers--;
                              });
                            },
                            child: Text('Unfollow'),
                          ),
                        )
                      : Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(32),
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size(
                                250,
                                50,
                              ),
                              textStyle: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              primary: Colors.blue,
                              onPrimary: Colors.black,
                            ),
                            onPressed: () async {
                              await FireStoreMethods().followUser(
                                FirebaseAuth.instance.currentUser!.uid,
                                userData['uid'],
                              );

                              setState(() {
                                isuserFollowing = true;
                                followers++;
                              });
                            },
                            child: const Text('Follow'),
                          ),
                        ),
            ],
          ),
        ],
      ),
    );
  }
}
