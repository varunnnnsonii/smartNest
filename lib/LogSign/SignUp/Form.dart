import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:fluttercuredoc/LogSign/SignUp/SignUp_backend.dart';
import 'package:fluttercuredoc/LogSign/SignUp/VerifyEmail.dart';
import 'package:fluttercuredoc/LogSign/Welcome.dart';

class Validator{
  static String? validateEmptyText(String? fieldName,String ?value){
    if(value== null || value.isEmpty){
      return '$fieldName is required';
    }
    return null;
  }

  static String? validatePassword(String ?value){
    if(value== null || value.isEmpty){
      return 'Password is required';
    }
    return null;
  }

  static String? validatePhoneNumber(String ?value){
    if(value== null || value.isEmpty){
      return 'Phone Number is required';
    }
    return null;
  }

  static String? validateEmail(String? value){
    if(value== null || value.isEmpty){
      return 'Email is required';
    }
    return null;
  }
}
class SignUpFormWidget extends StatelessWidget {
  const SignUpFormWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 30- 10),
      child: Form(
        key: controller.signupFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.fullName,
              validator: (value) => Validator.validateEmptyText('FullName', value),
              style: TextStyle(color: Colors.black), // Set input text color to white
              decoration: InputDecoration(
                labelText: 'FullName',
                labelStyle: TextStyle(color: Colors.black), // Set title color to white
                prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.black), // Set icon color to white
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
              ),
            ),

            const SizedBox(height: 30 - 20),
            TextFormField(
                controller: controller.userName,
              validator: (value)=>Validator.validateEmptyText('UserName', value) ,
              style: TextStyle(color: Colors.black), // Set input text color to white
              decoration: InputDecoration(
                labelText: 'UserName',
                labelStyle: TextStyle(color: Colors.black), // Set title color to white
                prefixIcon: Icon(Icons.person_outline_rounded, color: Colors.black), // Set icon color to white
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
              ),            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
                controller: controller.email,
              validator: (value)=>Validator.validateEmail(value) ,
              style: TextStyle(color: Colors.black), // Set input text color to white
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black), // Set title color to white
                prefixIcon: Icon(Icons.email_outlined, color: Colors.black), // Set icon color to white
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
              ),            ),
            const SizedBox(height: 30 - 20),
            TextFormField(
              keyboardType: TextInputType.phone,
                controller: controller.phoneNo,
              validator: (value)=>Validator.validatePhoneNumber( value) ,
              style: TextStyle(color: Colors.black), // Set input text color to white
              decoration: InputDecoration(
                labelText: 'PhoneNo',
                labelStyle: TextStyle(color: Colors.black), // Set title color to white
                prefixIcon: Icon(Icons.phone, color: Colors.black), // Set icon color to white
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black), // Set border color to white
                ),
              ),
            ),
            const SizedBox(height: 30 - 20),
            Obx(
              ()=>TextFormField(
                  controller: controller.password,
                validator: (value)=>Validator.validatePassword( value) ,
                style: TextStyle(color: Colors.black), // Set input text color to white
                obscureText: controller.hidePassword.value,
                decoration:InputDecoration(
                  labelStyle: TextStyle(color: Colors.black),
                    label: Text('Password',style: TextStyle(color: Colors.black),),
                    prefixIcon: Icon(Icons.fingerprint,color: Colors.black,),
                    suffixIcon: IconButton(
                      onPressed:() => controller.hidePassword.value = !controller.hidePassword.value,
                        icon: Icon(controller.hidePassword.value ? Icons.remove_red_eye_outlined :Icons.remove_red_eye,color: Colors.black,),),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black), // Set border color to white
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black), // Set border color to white
                  ),),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              width: double.infinity,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.lightBlue.shade100, Colors.lightBlue], // Your gradient colors
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
                    backgroundColor: Colors.transparent, // Make button transparent
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                  onPressed:() => controller.signup(),
                  child: Text(
                    "Signup".toUpperCase(),
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}