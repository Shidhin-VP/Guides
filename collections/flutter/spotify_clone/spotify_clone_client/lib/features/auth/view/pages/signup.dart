import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/utils/general_app_status.dart';
import 'package:spotify_clone_client/core/theme/custom_field.dart';
import 'package:spotify_clone_client/core/widgets/loader.dart';
import 'package:spotify_clone_client/features/auth/view/pages/login.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_rich_text_nav.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_title_text.dart';
import 'package:spotify_clone_client/features/auth/viewmodel/auth_view_model.dart';

class SignUp extends ConsumerStatefulWidget {
  const SignUp({super.key});

  @override
  ConsumerState<SignUp> createState() => _SignUpState();
}

class _SignUpState extends ConsumerState<SignUp> {
  //Variable Init.
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = ref.watch(authViewModelProvider)?.isLoading == true;
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          showAppStatus(context, message: "SignUp Success, Please Login");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => LoginPage()),
          );
        },
        error: (error, st) {
          showAppStatus(context, message: error.toString(), error: true);
        },
        loading: () {},
      );
    });
    return Scaffold(
      appBar: AppBar(),
      body: isLoading
          ? Loader()
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    authTitleText("SignUp"),
                    SizedBox(height: 15),
                    CustomTextField(
                      controller: nameController,
                      hintText: "Name",
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                    ),
                    SizedBox(height: 10),
                    CustomTextField(
                      isObscure: true,
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    SizedBox(height: 20),
                    AuthGradientButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authViewModelProvider.notifier)
                              .signUpUser(
                                nameController.text,
                                emailController.text,
                                passwordController.text,
                              );
                        }
                      },
                      buttonText: "SignUp",
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: ((context) => LoginPage()),
                          ),
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
            ),
    );
  }
}
