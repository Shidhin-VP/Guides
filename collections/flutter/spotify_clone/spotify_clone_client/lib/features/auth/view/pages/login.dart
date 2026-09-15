import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify_clone_client/core/widgets/custom_field.dart';
import 'package:spotify_clone_client/core/utils/general_app_status.dart';
import 'package:spotify_clone_client/core/widgets/loader.dart';
import 'package:spotify_clone_client/features/auth/view/pages/signup.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_gradient_button.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_rich_text_nav.dart';
import 'package:spotify_clone_client/features/auth/view/widgets/auth_title_text.dart';
import 'package:spotify_clone_client/features/auth/viewmodel/auth_view_model.dart';
import 'package:spotify_clone_client/features/home/view/pages/home_page.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  // Variable Init
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      authViewModelProvider.select((val) => val?.isLoading == true),
    );
    ref.listen(authViewModelProvider, (_, next) {
      next?.when(
        data: (data) {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
            (_) => false,
          );
          showAppStatus(
            context,
            message: "Login Success!, Welcome Back ${data.name}",
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
                    authTitleText("SignIn"),
                    SizedBox(height: 15),
                    CustomTextField(
                      controller: emailController,
                      hintText: "Email",
                    ),
                    SizedBox(height: 15),
                    CustomTextField(
                      controller: passwordController,
                      hintText: "Password",
                    ),
                    SizedBox(height: 20),
                    AuthGradientButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          ref
                              .read(authViewModelProvider.notifier)
                              .loginUser(
                                emailController.text,
                                passwordController.text,
                              );
                        } else {
                          showAppStatus(
                            context,
                            message: "Please Fill All Required Fields!",
                            error: true,
                          );
                        }
                      },
                      buttonText: "Login",
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignUp()),
                      ),
                      child: AuthRichTextNav(
                        welcomeText: "Don't Have an Account? ",
                        action: "SignUp!",
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
