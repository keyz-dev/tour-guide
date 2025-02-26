import 'package:flutter/material.dart';
import 'package:tour_aid/components/my_text.dart';
import 'package:tour_aid/utils/colors.dart';

class ProfileMenuWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onPress;
  final String? endText;
  final Color textColor;

  const ProfileMenuWidget(
      {super.key,
      required this.title,
      required this.icon,
      this.onPress,
      this.endText,
      this.textColor = const Color(0xFF333333)});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: AppColors.secondaryBlue.withOpacity(0.15)),
        child: Icon(
          icon,
          color: AppColors.indicatorActive,
        ),
      ),
      title: MyText(
        text: title,
        size: 18,
        color: textColor,
      ),
      trailing: endText != null
          ? MyText(
              text: endText!,
              size: 14,
              color: AppColors.primaryGrey,
            )
          : null,
    );
  }
}
