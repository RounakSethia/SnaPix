
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pixapp/widgets/theme_widgets.dart';

//THis is to edit the details that you want to change, This is still in progress.
class EditProfilePage extends StatefulWidget {
  final String userid;
  EditProfilePage({Key? key, required this.userid}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController updateusernameTextEditingController =
      TextEditingController();
  final TextEditingController updatebioTextEditingController = TextEditingController();
  var userData = {};
  User? user;
  int postLength = 0;
  int followers = 0;
  int following = 0;
  bool isuserFollowing = false;
  bool loading = false;
  bool _bioValid = true;
  bool _profileNameValid = true;

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
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
  
  void initstate(){
    super.initState();
    getAndDisplayUserInformation();

  }
  getAndDisplayUserInformation()async{
    setState(() {
      loading = true;
    });

    // DocumentSnapshot documentSnapshot = await UserInfo.(widget.userid).get();
    // user = User.fromSnap(documentSnapshot);

    updateusernameTextEditingController.text = userData['useraname'];
    updatebioTextEditingController.text = userData['bio'];

    setState(() {
      loading = false;
    });

  }
  updateUserData(){
    setState(() {
      updateusernameTextEditingController.text.trim().length < 3 || updateusernameTextEditingController.text.isEmpty ? _profileNameValid = false : _profileNameValid = false;
    updatebioTextEditingController.text.trim().length > 110 ? _bioValid = false : _bioValid = true;
    });
    if(_bioValid && _profileNameValid){
      
      var userReference;
      userReference.document(widget.userid).updateData({
        "username": updateusernameTextEditingController.text,
        "bio": updatebioTextEditingController.text,
      });
      SnackBar successSnackbar = SnackBar(content: Text('Profile updated successfully'),);
    }
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Center(
            child: Text(
          "Edit Profile",
          style: TextStyle(color: themesSwitch ? Colors.white : Colors.black,),
        )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.done,
              color: Colors.white,
              size: 30.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: loading
          ? CircularProgressIndicator()
          : ListView(
              children: <Widget>[
                Container(
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 7.0),
                        child: CircleAvatar(
                          radius: 52.0,
                          backgroundImage: NetworkImage(userData['photoUrl']),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: <Widget>[
                            createProfileNameTextFormField(),
                            createBioTextFormField(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 150),
                        child: ElevatedButton(
                          child: Center(child: Text('Update')),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          onPressed: updateUserData,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Column createProfileNameTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Profile Name",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: updateusernameTextEditingController,
          decoration: InputDecoration(
            hintText: "Write username",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _profileNameValid ? null : "Usernname is very short",
          ),
        ),
      ],
    );
  }

  Column createBioTextFormField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(top: 13.0),
          child: Text(
            "Bio",
            style: TextStyle(color: Colors.grey),
          ),
        ),
        TextField(
          style: TextStyle(color: Colors.white),
          controller: updatebioTextEditingController,
          decoration: InputDecoration(
            hintText: "Write Bio ",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintStyle: TextStyle(color: Colors.grey),
            errorText: _bioValid ? null : "Bio is very Long.",
          ),
        ),
      ],
    );
  }
}
