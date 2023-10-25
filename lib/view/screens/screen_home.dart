
import 'package:flutter/material.dart';
import 'package:rushd/helpers/firebase_utils.dart';
import 'package:rushd/view/screens/screen_cart.dart';
import 'package:rushd/view/screens/screen_therapysession.dart';
import 'package:rushd/view/layouts/layout_mycourses.dart';
import 'package:rushd/view/layouts/layout_profile.dart';
import 'package:rushd/view/layouts/layout_Home.dart';

import '../../helpers/fcm.dart';
import '../../helpers/helper.dart';
import '../layouts/layout_cart.dart';
import '../layouts/layout_search.dart';



class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  var currentPage = 0;

  int currentIndex = 0;
  final pages = [
  LayoutHome(),LayoutSearch(),LayoutMycourses(),CartScreen(),LayoutProfile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

@override
  void initState() {
  UpdatenotificationToken();

  super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body:pages[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home
              ),
                  label: "Home"
              ),
              BottomNavigationBarItem(icon: Icon(Icons.search
              ),
                  label: "Search"
              ),
              BottomNavigationBarItem(icon: Icon(Icons.library_books_outlined
              ),
                  label: "My Courses"),
              BottomNavigationBarItem(icon: Icon(Icons.add_shopping_cart
              ),
                  label: "My cart"
              ),
              BottomNavigationBarItem(icon: Icon(Icons.person
              ),
                  label: "Profile"
              ),


            ],

            selectedIconTheme: IconThemeData(color: Colors.blue),
            selectedItemColor: Colors.blue,
            unselectedIconTheme: IconThemeData(color: Colors.black),
            onTap: (index){
              setState(() {
                currentIndex =index;
              });
            },

          )
      ),
    );
  }
  void UpdatenotificationToken()async{
    var token = await FCM.generateToken()?? 0;
    await usersRef.doc(FirebaseUtils.myId).update({"notificationToken":token});
  }

}
