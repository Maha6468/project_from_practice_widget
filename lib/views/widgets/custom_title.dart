import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final Widget leading;
  final Widget title;
  final Widget? trailing;
  final VoidCallback? onTap;

  const CustomTitle({super.key,
    required this.leading,
    required this.title,
    this.trailing,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          children: [
            // Leading Icon
            leading,
            const SizedBox(width: 16.0), // Spacing between leading and text
            // Title and Subtitle
            Expanded(
              child: title,
            ),
            // Trailing Icon
            trailing ?? const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}