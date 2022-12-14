import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:person_portal/controller/login_controller.dart';
import 'package:person_portal/controller/mongo_controller.dart';
import 'package:person_portal/controller/person_data_controller.dart';
import 'package:person_portal/controller/person_profile_controller.dart';
import 'package:person_portal/controller/token_controller.dart';
import 'package:person_portal/helper/dialog_helper.dart';
import 'package:person_portal/repository/rest_repository.dart';
import 'package:person_portal/view/home_view.dart';
import 'package:person_portal/view/sign_up_view.dart';

class LoginPage extends StatelessWidget {
  //const LoginPage({super.key})

  final mongoController = Get.put(MongoController());
  final loginController = Get.put(LoginController());
  final tokenController = Get.put(TokenController());
  final profileController = Get.put(PersonProfileController());
  final personDataController = Get.put(PersonDataController());

  final TextEditingController userInput = TextEditingController();
  final TextEditingController passwordInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const Icon(
              Icons.person,
              size: 100,
            ),
            const SizedBox(height: 20),
            const Text(
              'Login',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: loginController.userName.value,
              enabled: true,
              autofocus: true,
              decoration: InputDecoration(
                prefixIcon: const IconButton(
                  icon: Icon(null),
                  onPressed: null,
                ),
                suffixIcon: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () {
                      loginController.userName.value.clear();
                      loginController.checkIfCanLogin();
                    }),
                border: const OutlineInputBorder(),
                labelText: 'Username',
              ),
              onChanged: (value) {
                loginController.checkIfCanLogin();
              },
            ),
            const SizedBox(height: 20),
            Obx(() => TextField(
                  controller: loginController.passWord.value,
                  obscureText: loginController.hidePassword.value,
                  enabled: true,
                  decoration: InputDecoration(
                    prefixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        loginController.hidePassword.value = !loginController.hidePassword.value;
                      },
                    ),
                    suffixIcon: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          loginController.passWord.value.clear();
                          loginController.checkIfCanLogin();
                        }),
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (value) {
                    loginController.checkIfCanLogin();
                  },
                )),
            const SizedBox(height: 20),
            Obx(() => Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              loginController.canLogin.value ? Colors.blue : Colors.grey),
                        ),
                        onPressed: loginController.canLogin.value
                            ? () async {
                          await RestRepository().LogIn();
                          loginController.checkIfCanLogin();

                          if (loginController.loggedIn.value) {
                            DialogHelper.showSnackBar(
                                title: 'Login', message: 'User logged-in successfully.', duration: 5);
                            Future.delayed(const Duration(seconds: 1), () async {
                              await RestRepository().FetchPersonData();
                              Get.to(() => HomePage());
                            });
                          }
                              }
                            : null,
                        child: Text('Login'),
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                    ),
                    onPressed: () {
                      loginController.resetLoginController();
                      Get.to(() => SignUpPage());
                    },
                    child: Text('Sign Up'),
                  ),
                ),
              ],
            ),
            Obx(() => Expanded(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SafeArea(
                      child: Text(
                          'Retries attempted: ${loginController.retriesAttempted.value} of ${loginController.maxRetries.value}'),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
