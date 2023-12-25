import 'package:flutter/material.dart';
import 'package:p4ds/providers/main_provider.dart';
import 'package:p4ds/providers/user_provider.dart';
import 'package:p4ds/screens/main_screens/hairline_screens.dart';
import 'package:p4ds/screens/main_screens/home_screen.dart';
import 'package:p4ds/screens/main_screens/scalp_screen.dart';
import 'package:p4ds/screens/main_screens/solutions_screen.dart';
import 'package:p4ds/screens/Profile/profile.dart';
import 'package:provider/provider.dart';


class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final up = Provider.of<UserProvider>(context);
    final mp = Provider.of<MainProvider>(context);

    return Scaffold(

      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20,top:20),
            child: IconButton(
              icon: const Icon(Icons.account_circle_rounded, size: 48, color: Colors.grey),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Profile() )
                );
              },
            ),
          ),
        ],
        toolbarHeight: 70, // default is 56
        automaticallyImplyLeading: false,
        backgroundColor: Color(0xFFEEEEEE), // Replace '123456' with your CSS hex color code
        shadowColor: Colors.transparent,
        title: GestureDetector(
          onTap: () {
            mp.onChangeMainScreenIndex(0);

            // Add navigation to the home screen here
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MainScreen()),
            );

          },
          child: Padding(
            padding: EdgeInsets.only(top:20), // Adjust the padding as needed
            child: Container(
              width: 60,
              child: Image.asset('assets/images/logo.png'),
            ),
          ),        ),
      ),
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: mp.mainPageController,
        onPageChanged: (index) => mp.onChangeMainScreenIndex(index),
        children: const [
          HomeScreen(),
          ScalpScreen(),
          SolutionsScreen(),
          HairlineScreen(),
        ],
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.4,
              child: DrawerHeader(
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CircleAvatar(
                          radius: 60,
                          backgroundColor: Colors.grey,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      'Group4',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '서울대학교',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        const Row(
                          children: [
                            Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            Text(
                              ' 368',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.edit_document),
              iconColor: Colors.grey.shade600,
              focusColor: Colors.grey.shade600,
              title: const Text('Edit Profile'),
              onTap: () => mp.onPressEditProfileButton(context),
              trailing: const Icon(Icons.navigate_next),
            ),
            const Expanded(child: SizedBox()),
            ListTile(
              leading: const Icon(Icons.settings),
              iconColor: Colors.black,
              focusColor: Colors.black,
              title: const Text('설정'),
              onTap: () {},
              trailing: const Icon(Icons.navigate_next),
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              iconColor: Colors.black,
              focusColor: Colors.black,
              title: const Text('로그아웃'),
              onTap: () {},
              trailing: const Icon(Icons.navigate_next),
            ),
            const SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => mp.onTapItem(index),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade100,
        selectedIconTheme: const IconThemeData(color: Colors.greenAccent),
        selectedItemColor: Colors.greenAccent,
        unselectedIconTheme: IconThemeData(color: Colors.grey.shade600),
        unselectedItemColor: Colors.grey.shade600,
        currentIndex: mp.pageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Scalp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.light),
            label: 'Solutions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.face),
            label: 'Hairline',
          ),
        ],
      ),
    );
  }
}
