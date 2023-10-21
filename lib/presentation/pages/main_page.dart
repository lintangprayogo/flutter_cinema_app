import 'package:cinema_app/presentation/extensions/build_extensions.dart';
import 'package:cinema_app/presentation/providers/router/router_provider.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<MainPage> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  Widget build(BuildContext context) {
    ref.listen(
      userDataProvider,
      (previous, next) {
        if (previous != null && next is AsyncData && next.value == null) {
          ref.read(routerProvider).goNamed('login');
        } else if (next is AsyncError) {
          context.showSnackBar(next.error.toString());
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main Page"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(ref.read(userDataProvider).when(
                data: (data) => data.toString(),
                error: (error, stackTrace) => '',
                loading: () => "Loading",
              )),
          ElevatedButton(
              onPressed: () {
                ref.read(userDataProvider.notifier).logout();
              },
              child: const Text("Logout"))
        ],
      ),
    );
  }
}
