import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  final Color color;
  final String text;
  final double size;
  final TextAlign? align;
  final FontWeight? weight;
  final double height;
  final TextOverflow overFlow;

  const MyText(
      {super.key,
        this.color = const Color(0xFF333333),
        required this.text,
        this.size = 24,
        this.weight,
        this.align,
        this.height = 1.2,
        this.overFlow = TextOverflow.visible
      });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: GoogleFonts.plusJakartaSans(
          fontSize: size,
          fontWeight: weight ?? FontWeight.w500,
          color: color,
          height: height),
      textAlign: align ?? TextAlign.left,
    );
  }
}
