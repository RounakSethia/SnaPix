import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pixapp/Firebase/auth_methods.dart';
import 'package:pixapp/Pages/login.dart';
import 'package:pixapp/Pages/home.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  bool _isobsecure = true;
  Uint8List? _image;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _usernameController.dispose();
  }

  void signUpUser() async {
    //   // signup user using our authmethodds
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!);
     // if string returned is sucess, user has been created
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const InputScreen(
            HomeScreenLayout: HomePage(),
          ),
        ),
      );
    } else {
      showSnackBar(context, res);
    }
  }

// for picking up image from gallery
pickImage(ImageSource source) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? _file = await _imagePicker.pickImage(source: source);
  if (_file != null) {
    return await _file.readAsBytes();
  }
  print('You didn\'t select the image');
}
// for displaying snackbars
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

  selectImage() async {
    Uint8List img = await pickImage(ImageSource.gallery);
    setState(() {
      _image = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Color(0x665ac18e),
          Color(0x995ac18e),
          Color(0xcc5ac18e),
          Color(0xff5ac18e),
        ]),
      ),
      alignment: Alignment.center,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 55,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Join now to become famous...',
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ]),
            ),
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 64,
                    backgroundImage: NetworkImage(
                      'https://jamhair.co.nz/wp-content/uploads/2022/05/avatar.png',
                    ),
                    backgroundColor: Colors.black,
                  ),
                  Positioned(
                    bottom: 2,
                    left: 75,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                        border: Border.all(color: Colors.white, width: 1),
                      ),
                      child: IconButton(
                        onPressed: selectImage,
                        icon:
                            const Icon(Icons.add_a_photo, color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(
                    hintText: 'Username',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.face_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.email_rounded,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextField(
                  obscureText: _isobsecure,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.lock_person_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          _isobsecure = !_isobsecure;
                        });
                      },
                      child: Icon(
                        _isobsecure ? Icons.visibility : Icons.visibility_off,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 40.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(2),
                child: TextField(
                  controller: _bioController,
                  decoration: const InputDecoration(
                    hintText: 'Bio',
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.edit_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 45),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.pinkAccent[400],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: InkWell(
                  onTap: signUpUser,
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Already a Snapix member. ",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            )
          ]),
    )
        // resizeToAvoidBottomInset: false,
        // body: SafeArea(
        //   child: Container(
        //     padding: const EdgeInsets.symmetric(horizontal: 32),
        //     width: double.infinity,
        //     child: Column(
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         Flexible(
        //           flex: 2,
        //           child: Container(),
        //         ),
        //         SvgPicture.asset(
        //           'assets/images/ic_instagram.svg',
        //           color: primaryColor,
        //           height: 64,
        //         ),
        //         const SizedBox(
        //           height: 64,
        //         ),
        //         Stack(
        //           children: [
        //             _image != null
        //                 ? CircleAvatar(
        //                     radius: 64,
        //                     backgroundImage: MemoryImage(_image!),
        //                     backgroundColor: Colors.red,
        //                   )
        //                 : const CircleAvatar(
        //                     radius: 64,
        //                     backgroundImage: NetworkImage(
        //                         'https://i.stack.imgur.com/l60Hf.png'),
        //                     backgroundColor: Colors.red,
        //                   ),
        //             Positioned(
        //               bottom: -10,
        //               left: 80,
        //               child: IconButton(
        //                 onPressed: selectImage,
        //                 icon: const Icon(Icons.add_a_photo),
        //               ),
        //             )
        //           ],
        //         ),
        //         const SizedBox(
        //           height: 24,
        //         ),
        //         TextFieldInput(
        //           hintText: 'Enter your username',
        //           textInputType: TextInputType.text,
        //           textEditingController: _usernameController,
        //         ),
        //         const SizedBox(
        //           height: 24,
        //         ),
        //         TextFieldInput(
        //           hintText: 'Enter your email',
        //           textInputType: TextInputType.emailAddress,
        //           textEditingController: _emailController,
        //         ),
        //         const SizedBox(
        //           height: 24,
        //         ),
        //         TextFieldInput(
        //           hintText: 'Enter your password',
        //           textInputType: TextInputType.text,
        //           textEditingController: _passwordController,
        //           isPass: true,
        //         ),
        //         const SizedBox(
        //           height: 24,
        //         ),
        //         TextFieldInput(
        //           hintText: 'Enter your bio',
        //           textInputType: TextInputType.text,
        //           textEditingController: _bioController,
        //         ),
        //         const SizedBox(
        //           height: 24,
        //         ),
        //         InkWell(
        //           onTap: signUpUser,
        //           child: Container(
        //             width: double.infinity,
        //             alignment: Alignment.center,
        //             padding: const EdgeInsets.symmetric(vertical: 12),
        //             decoration: const ShapeDecoration(
        //               shape: RoundedRectangleBorder(
        //                 borderRadius: BorderRadius.all(Radius.circular(4)),
        //               ),
        //               color: blueColor,
        //             ),
        //             child: !_isLoading
        //                 ? const Text(
        //                     'Sign up',
        //                   )
        //                 : const CircularProgressIndicator(
        //                     color: primaryColor,
        //                   ),
        //           ),
        //         ),
        //         const SizedBox(
        //           height: 12,
        //         ),
        //         Flexible(
        //           flex: 2,
        //           child: Container(),
        //         ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.center,
        //           children: [
        //             Container(
        //               padding: const EdgeInsets.symmetric(vertical: 8),
        //               child: const Text(
        //                 'Already have an account?',
        //               ),
        //             ),
        //             GestureDetector(
        //               onTap: () => Navigator.of(context).push(
        //                 MaterialPageRoute(
        //                   builder: (context) => const LoginScreen(),
        //                 ),
        //               ),
        //               child: Container(
        //                 padding: const EdgeInsets.symmetric(vertical: 8),
        //                 child: const Text(
        //                   ' Login.',
        //                   style: TextStyle(
        //                     fontWeight: FontWeight.bold,
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
        );
  }
}
