import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/custom_field.dart';
import 'package:spotify_clone_client/features/auth/view/pages/signup.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_rich_text_nav.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_title_text.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            authTitleText("SignIn"),
            SizedBox(height: 15),
            CustomTextField(hintText: "Email"),
            SizedBox(height: 15),
            CustomTextField(hintText: "Password"),
            SizedBox(height: 20),
            AuthGradientButton(buttonText: "Login"),
            SizedBox(height: 15),
            GestureDetector(
              onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
              child: AuthRichTextNav(
                welcomeText: "Don't Have an Account? ",
                action: "SignUp!",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
