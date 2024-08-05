import 'package:flutter/material.dart';
import 'package:roomah/src/res/colors.dart';

class RoomahTextStyle {
  static const labelSmall = TextStyle(
    color: RoomahColors.textSecondary,
    fontSize: 12,
  );
  static const labelMedium = TextStyle(
    color: RoomahColors.textSecondary,
    fontSize: 16,
  );
  static const labelLarge = TextStyle(
    color: RoomahColors.textSecondary,
    fontSize: 24,
  );

  static const titleSmall = TextStyle(
    color: RoomahColors.textPrimary,
    fontSize: 12,
  );
  static const titleMedium = TextStyle(
    color: RoomahColors.textPrimary,
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );
  static const titleLarge = TextStyle(
    color: RoomahColors.textPrimary,
    fontSize: 24,
  );
}

class RoomahText extends StatelessWidget {
  const RoomahText(
    this.label, {
    super.key,
    this.textStyle = RoomahTextStyle.labelSmall,
  });

  final String label;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: textStyle,
    );
  }
}
