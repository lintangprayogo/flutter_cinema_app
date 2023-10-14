
import 'package:cinema_app/domain/entities/result.dart';
import 'package:cinema_app/domain/usecases/login/login_params.dart';
import 'package:cinema_app/presentation/pages/main_page.dart';
import 'package:cinema_app/presentation/providers/usecase/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Login"),
          onPressed: () {
            final login = ref.watch(loginProvider);

            login
                .call(const LoginParams(
                    email: "lintang@cpssoft.com", password: "12345678"))
                .then(
              (result) {
                if (result is Success) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MainPage(user: result.resultValue!),
                      ),
                      (route) => false);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(result.errorMessage ?? "Unknown Error")));
                }
              },
            );
          },
        ),
      ),
    );
  }
}
