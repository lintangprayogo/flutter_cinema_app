import 'package:cinema_app/presentation/extensions/integer_extensions.dart';
import 'package:cinema_app/presentation/misc/methods.dart';
import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget headerUserInfo(WidgetRef ref) {
  return Padding(
    padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
    child: Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey, width: 1),
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: ref.watch(userDataProvider).valueOrNull?.photo != null
                      ? NetworkImage(
                              ref.watch(userDataProvider).valueOrNull!.photo!)
                          as ImageProvider
                      : const AssetImage("assets/pp-placeholder.png"),
                  fit: BoxFit.cover)),
        ),
        horizontalSpace(16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${getGreating()} ${ref.watch(userDataProvider).when(
                    data: (user) => user?.name.split(" ").first,
                    error: (error, stackTrace) => '',
                    loading: () => 'Loading',
                  )}",
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Let's watch your favorite movie!",
              style: TextStyle(fontSize: 12),
            ),
            verticalSpace(5),
            Row(
              children: [
                SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset("assets/wallet.png"),
                ),
                horizontalSpace(10),
                Text(
                  ref.watch(userDataProvider).when(
                        data: (user) => (user?.balance ?? 0).toIdrFormat(),
                        error: (error, stackTrace) => 0.toIdrFormat(),
                        loading: () => "Loading",
                      ),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}

String getGreating() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return "Good Morning";
  } else if (hour < 18) {
    return "Good Afternoon";
  } else {
    return "Good Evening";
  }
}
