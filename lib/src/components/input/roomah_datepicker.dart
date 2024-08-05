import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:roomah/src/components/bottomsheet/date_picker_sheet.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:roomah/src/res/colors.dart';

class RoomahDatePicker extends StatefulWidget {
  final String label;
  final DateTime? datePicked;
  final String? errorMessage;
  final TextEditingController? controller;
  final Function(DateTime val) onSubmit;
  final String? semanticsLabel;

  const RoomahDatePicker(this.label,
      {super.key,
      required this.datePicked,
      required this.onSubmit,
      this.errorMessage,
      this.controller,
      this.semanticsLabel});

  @override
  State<RoomahDatePicker> createState() => _RoomahDatePickerState();
}

class _RoomahDatePickerState extends State<RoomahDatePicker> {
  DateTime? datePicked;

  @override
  void initState() {
    super.initState();
    datePicked = widget.datePicked;
  }

  bool isError() {
    if (widget.errorMessage != null && widget.errorMessage!.isNotEmpty) {
      return true;
    }
    return false;
  }

  void showBirthdatePicker() async {
    await showModalBottomSheet(
      backgroundColor: Colors.transparent,
      enableDrag: true,
      context: context,
      builder: (bottomSheetContext) {
        return DatePickerSheet(
          initialDate: datePicked,
        );
      },
    ).then((value) {
      if (value != null) {
        setState(() {
          datePicked = value;
          widget.onSubmit(datePicked!);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    datePicked = widget.datePicked;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Semantics(
          label: widget.semanticsLabel ?? '',
          child: InkWell(
            child: GestureDetector(
              onTap: () => showBirthdatePicker(),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                      color:
                          isError() ? Colors.red : RoomahColors.primaryAccent,
                      width: 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(16, 8, 8, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (datePicked != null)
                              const Text(
                                'Date',
                                style: RoomahTextStyle.labelSmall,
                              ),
                            Text(
                              datePicked != null
                                  ? DateFormat('dd MMMM yyyy')
                                      .format(datePicked!)
                                  : 'Date of birth',
                              style: RoomahTextStyle.labelMedium,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(
                          Icons.calendar_today_outlined,
                          size: 24,
                        ),
                        onPressed: () => showBirthdatePicker(),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        if (isError())
          Text(
            isError() ? widget.errorMessage! : '',
            style: RoomahTextStyle.labelMedium,
          )
      ],
    );
  }
}
