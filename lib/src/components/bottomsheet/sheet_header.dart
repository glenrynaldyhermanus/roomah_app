import 'package:flutter/material.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:roomah/src/res/colors.dart';

class SheetHeader extends StatefulWidget {
  const SheetHeader({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<SheetHeader> createState() => _SheetHeaderState();
}

class _SheetHeaderState extends State<SheetHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(0, 12, 0, 0),
                child: Container(
                  width: 50,
                  height: 4,
                  decoration: BoxDecoration(
                    color: RoomahColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(8, 16, 8, 0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.close,
                    size: 24,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                RoomahText(
                  widget.title,
                  textStyle: RoomahTextStyle.titleMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
