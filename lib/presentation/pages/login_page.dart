import 'package:cinema_app/presentation/extensions/build_extensions.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

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
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text("Login"),
          onPressed: () {
            ref
                .read(userDataProvider.notifier)
                .login(email: "lintang@cpssoft.com", password: "12345678");
          },
        ),
      ),
    );
  }
}
