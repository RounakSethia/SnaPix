import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pixapp/Pages/addsnapix.dart';
import 'package:pixapp/Pages/snapix.dart';
import 'package:pixapp/Pages/profile.dart';
import 'package:pixapp/Pages/search.dart';
import 'package:pixapp/widgets/custom_icon_widgets.dart';
import 'package:pixapp/widgets/theme_widgets.dart';

//Home Page that shows post from different users
class HomePage extends StatefulWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int pageIdx = 0;
  late PageController pageController;

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
        automaticallyImplyLeading: false,
        backgroundColor: themeColors(),
        elevation: 0,
        brightness: themesSwitch ? Brightness.dark : Brightness.light,
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.contain,
              height: 60,
            ),
            Text(
              'Snapix',
              style: GoogleFonts.dancingScript(
                textStyle: TextStyle(
                    color: themesSwitch ? Colors.white : Colors.black,
                    fontSize: 38,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(
              CupertinoIcons.search_circle_fill,
              color: themesSwitch ? Colors.white : Colors.black,
              size: 35,
            ),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SearchPage(),
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                themesSwitch = !themesSwitch;
              });
            },
            icon: themesSwitch
                ? Icon(CupertinoIcons.sun_max_fill,
                    color: themesSwitch ? Colors.white : Colors.black)
                : Icon(CupertinoIcons.moon_fill,
                    color: themesSwitch ? Colors.white : Colors.black)
          ),
        ],
      ),
      body: Center(
        child: homeScreenItems[pageIdx],
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          labelTextStyle: MaterialStateProperty.all(TextStyle(fontSize: 12, color: themesSwitch ? Colors.white : Colors.black),),
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorColor: Colors.transparent,
        ),
        child: NavigationBar(
          backgroundColor: Colors.deepPurple,
          selectedIndex: pageIdx,
          height: 60,
          onDestinationSelected: (int idx) {
            setState(() {
              pageIdx = idx;
            });
          },
          destinations: [
            NavigationDestination(
              selectedIcon: Icon(
                CupertinoIcons.home,
                color: themesSwitch ? Colors.white : Colors.black,
                size: 33,
              ),
              icon: Icon(
                CupertinoIcons.home,
                color: themesSwitch ? Colors.white : Colors.black,
                size: 33,
              ),
              label: 'Home',
              
            ),
            NavigationDestination(
              selectedIcon: CustomIcon(),
              icon: CustomIcon(),
              label: ' ',
            ),
            NavigationDestination(
              selectedIcon: Icon(
                CupertinoIcons.person_fill,
                color: themesSwitch ? Colors.white : Colors.black,
                size: 33,
              ),
              icon: Icon(
                CupertinoIcons.person_fill,
                color: themesSwitch ? Colors.white : Colors.black,
                size: 33,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
