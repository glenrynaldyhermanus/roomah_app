import 'package:flutter/material.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:roomah/src/res/colors.dart';

class RoomahDropdown extends StatefulWidget {
  const RoomahDropdown(
      {super.key, required this.options, required this.onSelected});

  final List<String> options;
  final ValueChanged<String> onSelected;

  @override
  State<RoomahDropdown> createState() => _RoomahDropdownState();
}

class _RoomahDropdownState extends State<RoomahDropdown> {
  String category = '';

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: RoomahColors.primaryAccent),
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        child: PopupMenuButton<String>(
          onSelected: (String value) {
            setState(() {
              category = value;
            });
            widget.onSelected(value);
          },
          itemBuilder: (BuildContext context) {
            return widget.options.map((String choice) {
              return PopupMenuItem<String>(
                value: choice,
                child: RoomahText(
                  choice,
                  textStyle: RoomahTextStyle.labelMedium,
                ),
              );
            }).toList();
          },
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const RoomahText(
                      'Category',
                      textStyle: RoomahTextStyle.titleSmall,
                    ),
                    RoomahText(
                      category.isEmpty ? "Select Category" : category,
                      textStyle: RoomahTextStyle.labelMedium,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.arrow_drop_down),
            ],
          ),
        ),
      ),
    );
  }
}
