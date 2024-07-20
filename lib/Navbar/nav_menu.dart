import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:fluttercuredoc/Pages/Home/Home.dart';
import 'package:fluttercuredoc/Pages/userdata/user_profile.dart';
class NavigationMenu extends StatelessWidget {
  const NavigationMenu({super.key});

  @override
  Widget build(BuildContext context){
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Color(0xff7151A9),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
        child: Obx(
          ()=>SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap:(index) => controller.currentIndex.value = index,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(CupertinoIcons.house_fill, size: 27),
              title: Text("Home"),
              selectedColor: Colors.white,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(CupertinoIcons.map_fill, size: 27),
              title: Text("Map"),
              selectedColor: Colors.white,
            ),


            /// Profile
            SalomonBottomBarItem(
              icon: Icon(CupertinoIcons.person_2_fill, size: 27),
              title: Text("Community"),
              selectedColor: Colors.white,
            ),
          ],
        ),
        ),
      ),
      body: Obx(()=> controller.screens[controller.currentIndex.value]),
    );
  }

}

class NavigationController extends GetxController{
  final Rx<int> currentIndex= 0.obs;

  final screens = [HomePage(),userprofile()];
}