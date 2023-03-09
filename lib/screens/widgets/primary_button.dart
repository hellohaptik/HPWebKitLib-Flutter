import 'package:flutter/material.dart';

const kDefaultPadding = 20.0;

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.color,
    this.padding = const EdgeInsets.all(kDefaultPadding * 0.75),
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(40)),
      ),
      padding: padding,
      color: const Color(0xFF00A68B),
      minWidth: double.infinity,
      onPressed: onPressed,
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
