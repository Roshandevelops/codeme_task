import 'package:codeme_task/infrastructure/auth_controller.dart';
import 'package:codeme_task/presentation/auth/signin_screen.dart';
import 'package:codeme_task/presentation/home/home_screen.dart';
import 'package:codeme_task/widgets/app_button_widget.dart';
import 'package:codeme_task/widgets/textform_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authController = Provider.of<AuthController>(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text("Sign Up",
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/pngtree-online-registration-man-and-woman-fill-out-a-form-application-choice-png-image_4438049.png",
                  height: 200,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 10),
                TextformFieldWidget(
                    controller: nameController, hintText: "Name"),
                const SizedBox(height: 10),
                TextformFieldWidget(
                    controller: emailController, hintText: "Email"),
                const SizedBox(height: 10),
                TextformFieldWidget(
                  controller: passwordController,
                  hintText: "Password",
                  suffixIcon: const Icon(CupertinoIcons.eye_slash),
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                TextformFieldWidget(
                  controller: confirmPasswordController,
                  hintText: "Confirm Password",
                  suffixIcon: const Icon(CupertinoIcons.eye_slash),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.topRight,
                  child: Text.rich(
                    TextSpan(
                      text: "Already have an Account? ",
                      style: const TextStyle(fontWeight: FontWeight.w500),
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (_) => const SignInScreen()),
                              );
                            },
                          text: " Click here",
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: Colors.green),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                authController.isLoading
                    ? const CircularProgressIndicator()
                    : AppButtonWidget(
                        onTap: () async {
                          if (passwordController.text.trim() !=
                              confirmPasswordController.text.trim()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Passwords do not match")),
                            );
                            return;
                          }
                          await authController.signUp(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (authController.user != null && context.mounted) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()),
                            );
                          } else {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text(authController.errorMessage ??
                                        "Sign up failed")),
                              );
                            }
                          }
                        },
                        buttonText: "SIGN UP",
                        backgroundColor: Colors.green,
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
