import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prechart_mobile/endpoints/endpoints.dart';
import 'package:prechart_mobile/models/tokensModel.dart';
import 'package:prechart_mobile/providers/user_token_provider.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _showPassword = false;
  TextEditingController userInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();

  int loginAttempts = 0;
  Tokens? tokens;

  Future<bool> doLogin() async {
    setState(() {
      loginAttempts++;
    });

    tokens = await Endpoints().Login(userInput.text, passwordInput.text);

    if (tokens != null) {
      context.read<UserTokens>().clearUser();
      context.read<UserTokens>().setUser(
          bearerToken: tokens!.bearerToken,
          refreshToken: tokens!.refreshToken,
          apiKey: tokens!.apiKey,
          userName: tokens!.userName);

      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.person,
              size: 100,
            ),
            const Text(
              'Login',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: userInput,
              enabled: loginAttempts < 3,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordInput,
              obscureText: !_showPassword,
              enabled: loginAttempts < 3,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                    icon: Icon(Icons.remove_red_eye),
                    onPressed: () {
                      setState(() {
                        _showPassword = !_showPassword;
                      });
                    }),
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: loginAttempts < 3 ? Colors.blue : Colors.grey,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              onPressed: loginAttempts <= 3
                  ? () async {
                      if (loginAttempts < 3) {
                        var validCreds = await doLogin();

                        if (validCreds) {
                          Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                        } else {
                          final errorMessage = SnackBar(
                            content: loginAttempts < 3
                                ? Text('Invalid UserName and Password')
                                : Text('You have exceeded the maximum number of login attempts'),
                            duration: loginAttempts < 3 ? Duration(seconds: 2) : Duration(days: 1),
                            action: SnackBarAction(
                              label: 'dismiss',
                              onPressed: () {
                                if (loginAttempts >= 3) {
                                  if (Platform.isIOS) {
                                    exit(0);
                                  } else {
                                    SystemNavigator.pop();
                                  }
                                }
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(errorMessage);
                        }
                      }
                    }
                  : null,
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}
