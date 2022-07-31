import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixapp/Firebase/auth_methods.dart';
import 'package:pixapp/Pages/home.dart';
import 'package:pixapp/models/user_models.dart';
import 'package:pixapp/Pages/signup.dart';
import 'package:provider/provider.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isobsecure = true;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }
  
showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}
  void loginUser() async {
    String res = await AuthMethods().loginUser(
        email: _emailController.text, password: _passwordController.text);
    if (res == 'success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const InputScreen(
              HomeScreenLayout: HomePage(),
              // webScreenLayout: WebScreenLayout(),
            ),
          ),
          (route) => false);
    } else {
      showSnackBar(context, res);
    }
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
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Login',
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
                      'Welcome back! we missed you...',
                      style: GoogleFonts.playfairDisplay(
                        textStyle: const TextStyle(
                          fontSize: 15,
                          
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Column(
                        children: const [
                          SizedBox(
                            height: 150,
                            width: 150,
                            child: Image(
                              image: AssetImage('assets/images/logo.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: AnimatedTextKit(
                        animatedTexts: [
                          TyperAnimatedText(
                            'Snapix',
                            textStyle: const TextStyle(
                              fontSize: 35,
                              fontWeight: FontWeight.bold,
                              color: Colors.yellowAccent,
                            ),
                            speed: const Duration(milliseconds: 500),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
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
                padding: const EdgeInsets.symmetric(horizontal: 45),
                child: Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.pinkAccent[400],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: InkWell(
                    onTap: loginUser,
                    child: const Center(
                      child: Text(
                        'Login',
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
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Not a member. ",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SignupPage(),
                      ),
                    ),
                    child: const Text(
                      "Sign up",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }
}
class InputScreen extends StatefulWidget {
  final Widget HomeScreenLayout;
  const InputScreen({
    Key? key,
    required this.HomeScreenLayout,
  }) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    UserProvider _userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await _userProvider.refreshUser();
  }
  

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return widget.HomeScreenLayout;
    });
  }
}
