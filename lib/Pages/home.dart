import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixapp/Pages/addsnapix.dart';
import 'package:pixapp/Pages/snapix.dart';
import 'package:pixapp/Pages/profile.dart';
import 'package:pixapp/Pages/search.dart';
import 'package:pixapp/widgets/custom_icon_widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIdx = 0;
  late PageController pageController; // for tabs animation

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  List<Widget> homeScreenItems = [
    const SnapixPage(),
    const AddSnapixPage(),
    ProfilePage(userid: FirebaseAuth.instance.currentUser!.uid,),
    const SearchPage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 60,
            ),
            Text('Snapix',
                style: GoogleFonts.dancingScript(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 38,
                        fontWeight: FontWeight.bold))),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              CupertinoIcons.search_circle_fill,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>const SearchPage(),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              CupertinoIcons.bell_circle_fill,
              color: Colors.white,
              size: 35,
            ),
            onPressed: () {},
            // need to work on notifications
          ),
        ],
      ),
      body: Center(
        child: homeScreenItems[pageIdx],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: const NavigationBarThemeData(
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
        ),
        child: NavigationBar(
          backgroundColor: Colors.pinkAccent,
          selectedIndex: pageIdx,
          height: 60,
          onDestinationSelected: (int idx) {
            setState(() {
              pageIdx = idx;
            });
          },
          destinations: [
            const NavigationDestination(
              selectedIcon: Icon(
                CupertinoIcons.home,
                color: Colors.black,
                size: 33,
              ),
              icon: Icon(
                CupertinoIcons.home,
                color: Colors.white,
                size: 33,
              ),
              label: 'home',
            ),
            NavigationDestination(
              selectedIcon: CustomIcon(),
              icon: CustomIcon(),
              label: ' ',
            ),
            const NavigationDestination(
              selectedIcon: Icon(
                CupertinoIcons.person,
                color: Colors.black,
                size: 33,
              ),
              icon: Icon(
                CupertinoIcons.person,
                color: Color.fromARGB(255, 41, 21, 21),
                size: 33,
              ),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}
