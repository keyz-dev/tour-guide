import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyElevatedButton extends StatelessWidget {
  VoidCallback? onPressed;
  final Widget child;
  final Color backgroundColor;
  final double radius;
  final double height;
  final double width;
  final double elevation;
  final EdgeInsetsGeometry padding;

  MyElevatedButton(
      {super.key,
        required this.onPressed,
        required this.child,
        this.backgroundColor = const Color(0xFF0286FF),
        this.radius = 0.0,
        this.height = 48,
        this.elevation = 4.0,
        this.width = 200,
        this.padding = const EdgeInsets.all(10)});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: elevation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          padding: padding,
          minimumSize: Size(width, height),
        ),
        child: child);
  }
}
