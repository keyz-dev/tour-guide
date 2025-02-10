import 'package:flutter/material.dart';

class MyTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? disabledTextColor;
  final Color? backgroundColor;
  final Color? disabledBackgroundColor;
  final double? borderRadius;
  final BorderSide? borderSide;
  final double? elevation;
  final bool? enabled;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;

  const MyTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.disabledTextColor,
    this.backgroundColor,
    this.disabledBackgroundColor,
    this.borderRadius=5.0,
    this.width = 150,
    this.height = 48,
    this.borderSide,
    this.margin,
    this.elevation,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: width,
      decoration: BoxDecoration(
          borderRadius: borderRadius == null
              ? BorderRadius.circular(1.0)
              : BorderRadius.circular(borderRadius!)),
      child: TextButton(
        onPressed: enabled! ? onPressed : null,
        style: TextButton.styleFrom(
          backgroundColor: backgroundColor,
          disabledBackgroundColor: disabledBackgroundColor,
          shape: RoundedRectangleBorder(
            side: borderSide ?? BorderSide.none,
            borderRadius: borderRadius == null
                ? BorderRadius.circular(1.0)
                : BorderRadius.circular(borderRadius!)
          ),
          elevation: elevation,
        ),
        child: child,
      ),
    );
  }
}
