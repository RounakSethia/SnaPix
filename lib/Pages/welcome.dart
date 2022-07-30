import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixapp/Pages/login.dart';
import 'package:pixapp/Pages/signup.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: Colors.black,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 120),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 250,
                      width: 250,
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    Text('Snapix',style: GoogleFonts.playfairDisplay(textStyle: const TextStyle(fontSize: 30))),
                    const SizedBox(height: 100,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 72, 70, 70),
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          child: const Center(
                            child: Text("Login",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                          ),
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.black,
                            border: Border.all(
                              width: 3,
                              color: Colors.white,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: InkWell(
                          child: const Center(
                            child: Text("Register",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                          ),
                          onTap: () => Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => const SignupPage(),
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
    );
  }
}
