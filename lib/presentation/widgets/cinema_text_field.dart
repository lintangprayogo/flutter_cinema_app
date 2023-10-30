import 'package:cinema_app/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class CinemaTextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool obscureText;

  const CinemaTextFieldWidget(
      {super.key,
      required this.label,
      required this.controller,
      this.obscureText = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: ghostWhite)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade800)),
          label: Text(
            label,
            style: const TextStyle(color: ghostWhite),
          )),
    );
  }
}
