import 'package:codeme_task/infrastructure/auth_controller.dart';
import 'package:codeme_task/presentation/home/home_screen.dart';
import 'package:codeme_task/widgets/app_button_widget.dart';
import 'package:codeme_task/widgets/textform_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
                Text("Sign In",
                    style: Theme.of(context).textTheme.headlineLarge),
                const SizedBox(height: 10),
                Image.asset(
                  "assets/images/pngtree-online-registration-man-and-woman-fill-out-a-form-application-choice-png-image_4438049.png",
                  height: 200,
                  fit: BoxFit.cover,
                ),
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
                const SizedBox(height: 20),
                authController.isLoading
                    ? const CircularProgressIndicator()
                    : AppButtonWidget(
                        onTap: () async {
                          await authController.signIn(
                            emailController.text.trim(),
                            passwordController.text.trim(),
                          );
                          if (authController.user != null) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (_) => const HomeScreen()),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(authController.errorMessage ??
                                    "Login failed"),
                              ),
                            );
                          }
                        },
                        buttonText: "SIGN IN",
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
