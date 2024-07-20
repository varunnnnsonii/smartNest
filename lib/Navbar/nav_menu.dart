import 'package:flutter/material.dart';
import 'package:fluttercuredoc/Pages/Home.dart';
import 'package:fluttercuredoc/Profile/Profile.dart';
import 'package:get/get.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
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
          color: Color(0xFFA4BFA7),
        ),
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: Obx(
          ()=>SalomonBottomBar(
            currentIndex: controller.currentIndex.value,
            onTap:(index) => controller.currentIndex.value = index,
          items: [
            /// Home
            SalomonBottomBarItem(
              icon: Icon(Icons.home,size: 27,),
              title: Text("Home"),
              selectedColor: Colors.white,
            ),

            /// Likes
            SalomonBottomBarItem(
              icon: Icon(Icons.date_range_rounded,size: 25,),
              title: Text("Appoint"),
              selectedColor: Colors.white,
            ),

            /// Search
            SalomonBottomBarItem(
              icon: Icon(Icons.chat_rounded,size: 25,),
              title: Text("Chat"),
              selectedColor: Colors.white,
            ),

            /// Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.map_rounded,size: 25,),
              title: Text("Map"),
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

  final screens = [Home(),ProfilePage()];
}