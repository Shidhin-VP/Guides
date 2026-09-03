import 'package:flutter/material.dart';
import 'package:spotify_clone_client/core/theme/app_pallete.dart';
import 'package:spotify_clone_client/features/auth/widgets/auth_gradient_button.dart';
import 'package:spotify_clone_client/features/auth/widgets/custom_field.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  //Write Variable Here
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final formKey=GlobalKey<FormState>();

  // Write Dispose Here
  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose(); // Keep it at the end
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Sign Up.",
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              CustomField(hintText: "Name", controller: nameController),
              const SizedBox(height: 15),
              CustomField(hintText: "Email", controller: emailController),
              const SizedBox(height: 15),
              CustomField(hintText: "Password", controller: passwordController, isObscureText: true,),
              const SizedBox(height: 20),
              AuthGradientButton(),
              const SizedBox(height: 15),
              RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  text: "Already have an account?",
                  children: [
                    TextSpan(
                      text: " Sign In",
                      style: TextStyle(
                        color: Pallete.gradient2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
