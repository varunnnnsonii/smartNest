import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:fluttercuredoc/Compo/ElevatedButton.dart';
import 'package:fluttercuredoc/LogSign/ForgetPass/ForgetPass.dart';
import 'package:fluttercuredoc/LogSign/ForgetPass/Mail.dart';
import 'package:fluttercuredoc/LogSign/Login/login_backend.dart';
import 'package:fluttercuredoc/LogSign/SignUp/Form.dart';
import 'package:fluttercuredoc/Pages/Home/Home.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 30 - 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: controller.email,
              validator: (value) => Validator.validateEmail(value),
              style: TextStyle(color: Colors.black87), // Set input text color to white
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.person_outline_outlined,
                  color: Colors.black87, // Set icon color to white
                ),
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.black87), // Set title color to white
                hintText: 'Email',
                hintStyle: TextStyle(color: Colors.black87), // Set hint text color to white
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black87), // Set border color to white
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.black87), // Set border color to white
                ),
              ),
            ),

            const SizedBox(height: 30),
            Obx(
                  () => TextFormField(
                controller: controller.password,
                validator: (value) => Validator.validateEmptyText('Password',value),
                obscureText: controller.hidePassword.value,
                style: TextStyle(color: Colors.black87), // Set input text color to white
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.black87), // Set title color to white
                  prefixIcon: Icon(Icons.fingerprint, color: Colors.black87), // Set icon color to white
                  suffixIcon: IconButton(
                    onPressed: () => controller.hidePassword.value =
                    !controller.hidePassword.value,
                    icon: Icon(
                      controller.hidePassword.value
                          ? Icons.remove_red_eye_outlined
                          : Icons.remove_red_eye,
                      color: Colors.black87, // Set icon color to white
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black87), // Set border color to white
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black87), // Set border color to white
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30 - 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Obx(
                      () => Checkbox(
                          value: controller.rememberMe.value,
                          onChanged: (value) => controller.rememberMe.value =
                              !controller.rememberMe.value),
                    ),
                    Text('Remember me',style: TextStyle(color: Color(0xff7151A9)),),
                  ],
                ),
                TextButton(
                    onPressed: () =>
                      Get.to(ForgetPasswordMailScreen()),

                    child: const Text('Forget Password?',style: TextStyle(color: Color(0xffC7ADFF)),)),
              ],
            ),
            SizedBox(
              width: double.infinity,
              child:CustomElevatedButton(title: "LOGIN", color1: Color(0xffC7ADFF), color2: Color(0xff7151A9), onPressed: ()=>
                  controller.emailAndPasswordSignIn() , padh: 20, padv: 10)
            ),
          ],
        ),
      ),
    );
  }
}
