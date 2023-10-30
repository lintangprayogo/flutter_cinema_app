import 'package:cinema_app/presentation/extensions/build_extensions.dart';
import 'package:cinema_app/presentation/misc/constants.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:cinema_app/presentation/widgets/cinema_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next is AsyncData && next.value != null) {
          ref.read(routerProvider).goNamed("main");
        }
        if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(50),
          Center(
            child: Image.asset(
              'assets/logo.png',
              width: 150,
            ),
          ),
          verticalSpace(16),
          const CircleAvatar(
            radius: 50,
            child: Icon(
              Icons.add_a_photo,
              size: 50,
              color: Colors.white,
            ),
          ),
          verticalSpace(24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                CinemaTextFieldWidget(
                    label: "Email", controller: emailController),
                verticalSpace(24),
                CinemaTextFieldWidget(
                    label: "Name", controller: nameController),
                verticalSpace(24),
                CinemaTextFieldWidget(
                  label: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                verticalSpace(24),
                CinemaTextFieldWidget(
                  label: "Retype Password",
                  controller: rePasswordController,
                  obscureText: true,
                ),
                verticalSpace(24),
                Center(
                  child: switch (ref.watch(userDataProvider)) {
                    AsyncData(:final value) => value == null
                        ? SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                onPressed: () {
                                  final name = nameController.text;
                                  final email = emailController.text;
                                  final password = passwordController.text;
                                  final rePassword = rePasswordController.text;
                
                                  if (name.isEmpty ||
                                      email.isEmpty ||
                                      password.isEmpty ||
                                      rePassword.isEmpty) {
                                    context.showSnackBar(
                                        "Please Enter Fill The Form !!!");
                                  } else if (password != rePassword) {
                                    context.showSnackBar(
                                        "Password Does'nt Match !!!");
                                  } else {
                                    ref.read(userDataProvider.notifier).register(
                                        email: email,
                                        name: name,
                                        password: password);
                                  }
                                },
                                child: const Text(
                                  "Register",
                                  style: TextStyle(fontWeight: FontWeight.w500),
                                )),
                          )
                        : const Center(child: CircularProgressIndicator()),
                    _ => const Center(child: CircularProgressIndicator())
                  },
                ),
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Already have an account? ",
                      style: TextStyle(color: ghostWhite),
                    ),
                    TextButton(
                        onPressed: () {
                          ref.read(routerProvider).goNamed("login");
                        },
                        child: const Text(
                          "Login here",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))
                  ],
                ),
                verticalSpace(24)
              ],
            ),
          )
        ],
      ),
    );
  }
}
