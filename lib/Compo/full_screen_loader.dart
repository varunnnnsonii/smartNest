import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

 class FullScreenLoader{
  static void openLoadingDialog(String text, String animation){
  showDialog(context: Get.overlayContext!,
  barrierDismissible: false,
  builder:(_)=>PopScope(
  canPop: false,
  child: Container(
  color: Colors.blueAccent,
  width: double.infinity,
  height: double.infinity,
  child: Column(
  children: [
  const SizedBox(height: 250,),
  AnimationLoaderWidget(text:text,animation:animation),
  ],
  ),
  ),
  ),
  );
  }
  static stopLoading(){
  Navigator.of(Get.overlayContext!).pop();
  }
  }

class AnimationLoaderWidget extends StatelessWidget{
  const AnimationLoaderWidget({
    super.key,
    required this.text,
    required this.animation,
    this.showAction = false,
    this.actionText,
    this.onActionPressed,
  });
  final String text;
  final String animation;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(animation,
            width: 200,
          ),
          SizedBox(height: 16,),
          Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Text(
              text,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          SizedBox(height: 24,),
          showAction ?
          SizedBox(
            width: 250,
            child: OutlinedButton(
              onPressed: onActionPressed,
              style: OutlinedButton.styleFrom(backgroundColor: Colors.blueAccent),
              child: Text(
                actionText!,
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
              :const SizedBox(),
        ],
      ),
    );
  }
}

