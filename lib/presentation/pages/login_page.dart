import 'package:cinema_app/presentation/extensions/build_extensions.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:cinema_app/presentation/widgets/cinema_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed("main");
        }
        if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: ListView(
          children: [
            verticalSpace(100),
            Container(
              width: 200,
              height: 150,
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.png"))),
            ),
            verticalSpace(100),
            Column(
              children: [
                CinemaTextFieldWidget(
                    label: "Email", controller: emailController),
                verticalSpace(24),
                CinemaTextFieldWidget(
                  label: "Password",
                  controller: passwordController,
                  obscureText: true,
                ),
                Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          "Forgot Password",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ))),
                verticalSpace(24),
                switch (ref.watch(userDataProvider)) {
                  AsyncData(:final value) => value == null
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              "Login",
                              style: TextStyle(fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {
                              ref.read(userDataProvider.notifier).login(
                                  email: "lintang@cpssoft.com",
                                  password: "12345678");
                            },
                          ),
                        )
                      : const CircularProgressIndicator(),
                  _ => const CircularProgressIndicator()
                },
                verticalSpace(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? "),
                    TextButton(
                        onPressed: () {
                          ref.read(routerProvider).goNamed("register");
                        },
                        child: const Text(
                          'Register here',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
