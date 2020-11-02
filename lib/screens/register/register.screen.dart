import 'package:fireflutter_sample_app/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class RegisterScrreen extends StatefulWidget {
  @override
  _RegisterScrreenState createState() => _RegisterScrreenState();
}

class _RegisterScrreenState extends State<RegisterScrreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController displayNameController = TextEditingController();
  TextEditingController favoriteColorController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Column(
        children: [
          TextFormField(
            controller: emailController,
            decoration: InputDecoration(hintText: 'Email Address'),
          ),
          TextFormField(
            controller: passwordController,
            decoration: InputDecoration(hintText: 'Password'),
          ),
          TextFormField(
            controller: displayNameController,
            decoration: InputDecoration(hintText: 'displayName'),
          ),
          TextFormField(
            controller: favoriteColorController,
            decoration:
                InputDecoration(hintText: 'What is your favorite color?'),
          ),
          RaisedButton(
            onPressed: () async {
              loading = true;
              try {
                User user = await ff.register({
                  'email': emailController.text,
                  'password': passwordController.text,
                  'displayName': displayNameController.text,
                  'favoriteColor': favoriteColorController.text
                }, meta: {
                  "public": {
                    "notifyPost": true,
                    "notifyComment": true,
                  }
                });
                loading = false;
                await Get.defaultDialog(
                    middleText: 'Welcome ' + user.displayName);
                Get.toNamed('home');
              } catch (e) {
                loading = false;
                Get.snackbar('Error', e.toString());
              }
            },
            child: loading ? CircularProgressIndicator() : Text('Register'),
          ),
        ],
      ),
    );
  }
}