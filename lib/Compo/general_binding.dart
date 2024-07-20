import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fluttercuredoc/Compo/NetwokManager.dart';

class GeneralBindings extends Bindings{
  @override
  void dependencies(){
    Get.put(NetworkManager());
  }
}