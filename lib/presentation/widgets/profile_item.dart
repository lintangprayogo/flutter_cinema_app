import 'package:flutter/material.dart';

Widget profileItem(String title, {VoidCallbackAction? onTap}) =>
    GestureDetector(
      onTap: () => onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(title), const Icon(Icons.arrow_forward_ios)],
      ),
    );
