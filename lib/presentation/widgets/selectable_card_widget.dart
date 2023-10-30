import 'package:cinema_app/presentation/misc/constants.dart';
import 'package:flutter/material.dart';

class SelectableCardWidget extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final bool isSelected;
  final bool isEnable;

  const SelectableCardWidget(
      {super.key,
      required this.text,
      this.onTap,
      required this.isSelected,
      required this.isEnable});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isEnable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: isSelected ? saffron.withOpacity(0.3) : null,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: isEnable ? saffron : Colors.grey)),
        child: Text(
          text,
          style: TextStyle(color: isEnable ? ghostWhite : Colors.grey),
        ),
      ),
    );
  }
}
