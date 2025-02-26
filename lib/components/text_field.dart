import 'package:flutter/material.dart';
import 'package:tour_aid/utils/colors.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? labelText;
  final String? hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final VoidCallback? onTap;
  final FormFieldSetter<String>? onSaved;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final double? borderRadius;
  final bool? enabled;
  final int? maxLength;
  final int? maxLines;
  final IconData? icon;
  final bool hasBorder;
  final bool readOnly;

  const MyTextField({
    super.key,
    this.controller,
    this.labelText,
    this.hintText,
    this.keyboardType=TextInputType.multiline,
    this.obscureText = false,
    this.onTap,
    this.onSaved,
    this.onChanged,
    this.validator,
    this.fillColor,
    this.maxLength,
    this.maxLines=1,
    this.borderColor,
    this.textColor,
    this.borderRadius,
    this.enabled = true,
    this.readOnly = false,
    this.icon,
    this.hasBorder = false
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        prefixIcon: Icon(icon, color: AppColors.primaryGrey,),
        border: OutlineInputBorder(
          borderRadius: borderRadius == null
              ? BorderRadius.circular(5.0)
              : BorderRadius.circular(borderRadius!),
          borderSide: hasBorder ? BorderSide(color: borderColor ?? AppColors.inputBorderColor) : BorderSide.none,
        ),
        filled: fillColor != null,
        fillColor: fillColor,
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius == null
              ? BorderRadius.circular(8.0)
              : BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: Colors.blue),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius == null
              ? BorderRadius.circular(8.0)
              : BorderRadius.circular(borderRadius!),
          borderSide: const BorderSide(color: Colors.red),
        ),
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      maxLength: maxLength,
      maxLines: maxLines,
      onTap: onTap,
      onSaved: onSaved,
      onChanged: onChanged,
      validator: validator,
      readOnly: readOnly,
    );
  }
}
