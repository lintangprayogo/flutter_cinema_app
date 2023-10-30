import 'package:cinema_app/presentation/providers/usecase/user_data/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Map<double, SizedBox> _verticalSpaces = {};
Map<double, SizedBox> _horizontalSpaces = {};

SizedBox verticalSpace(double height) {
  if (!_verticalSpaces.containsKey(height)) {
    return SizedBox(
      height: height,
    );
  }
  return _verticalSpaces[height]!;
}

SizedBox horizontalSpace(double width) {
  if (!_horizontalSpaces.containsKey(width)) {
    return SizedBox(width: width);
  }
  return _horizontalSpaces[width]!;
}

List<Widget> userInfo(WidgetRef ref) => [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.grey, width: 1),
            image: DecorationImage(
                image: ref.watch(userDataProvider).valueOrNull?.photo != null
                    ? NetworkImage(
                            ref.watch(userDataProvider).valueOrNull!.photo!)
                        as ImageProvider
                    : const AssetImage("assets/pp-placeholder.png"),
                fit: BoxFit.cover)),
      ),
      Text(
        ref.watch(userDataProvider).valueOrNull?.name ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      Text(
        ref.watch(userDataProvider).valueOrNull?.email ?? '',
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 12),
      )
    ];
