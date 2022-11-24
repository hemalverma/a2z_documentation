import 'package:document_solution/Pages/home_page.dart';
import 'package:document_solution/Pages/profile_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int selectedPageIndex = 0;

  final pages = [const HomePage(),const ProfilePage()];


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: pages[selectedPageIndex],
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(CupertinoIcons.home),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(CupertinoIcons.profile_circled),
            ),
          ],
          currentIndex: selectedPageIndex,
          onTap: (index){
            setState((){
              selectedPageIndex = index;
            });
          },
        ),
      ),
    );
  }
}
