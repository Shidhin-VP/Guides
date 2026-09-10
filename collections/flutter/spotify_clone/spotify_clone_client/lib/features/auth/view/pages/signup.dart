import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/custom_field.dart';
import 'package:spotify_clone_client/features/auth/view/pages/login.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_rich_text_nav.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_title_text.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            authTitleText("SignUp"),
            SizedBox(height: 15),
            CustomTextField(hintText: "Name"),
            SizedBox(height: 10),
            CustomTextField(hintText: "Email"),
            SizedBox(height: 10),
            CustomTextField(hintText: "Password"),
            SizedBox(height: 20),
            AuthGradientButton(buttonText: "SignUp"),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: ((context) => LoginPage())),
                );
              },
              child: AuthRichTextNav(
                welcomeText: "Already Have an Account? ",
                action: "Login",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
