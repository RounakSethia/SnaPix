import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pixapp/Firebase/auth_methods.dart';
import 'package:pixapp/Pages/about.dart';
import 'package:pixapp/Pages/login.dart';

class SettingPage extends StatefulWidget {
  SettingPage({Key? key}) : super(key: key);

  @override
  State<SettingPage> createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            CupertinoIcons.back,
          ),
        ),
        title: const Padding(
          padding: EdgeInsets.only(left: 90.0),
          child: Text(
            'Settings',
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(8),
        child: ListView(children: [
          const SizedBox(
            height: 40,
          ),
                  
              Row(
                children: [
                  ClipOval(
                    child: Material(
                      color: Colors.white,
                      child: InkWell(
                        onTap: () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => aboutPage(),
                          ),
                        ),
                        child: const SizedBox(
                          width: 50,
                          height: 50,
                          child: Icon(
                            CupertinoIcons.person_2_square_stack_fill,
                            size: 40,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'ABOUT',
                    style: TextStyle(color: Colors.black, fontSize: 20),
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
                            fontSize: 18,
                            fontWeight: FontWeight.w900
                          ),
                          primary: Colors.white,
                          side: const BorderSide(
                            width: 1,
                            color: Colors.white,

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
                        child: const Text('SIGN OUT'),
                      ),
                    ),
                  const Divider(
                    height: 60,
                    thickness: 2,
                  ),
                ],
              ),
            ],
          )
        ),
      );
  }
}
