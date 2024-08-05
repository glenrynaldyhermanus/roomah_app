import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roomah/src/components/bottomsheet/sheet_header.dart';
import 'package:roomah/src/components/input/roomah_datepicker.dart';
import 'package:roomah/src/components/input/roomah_dropdown.dart';
import 'package:roomah/src/components/input/roomah_textfield.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:sticky_headers/sticky_headers.dart';

class CreateTransactionSheet extends StatefulWidget {
  const CreateTransactionSheet({super.key});

  @override
  CreateTransactionSheetState createState() => CreateTransactionSheetState();
}

class CreateTransactionSheetState extends State<CreateTransactionSheet> {
  FocusNode? unfocusNode;

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
  }

  @override
  void initState() {
    super.initState();
    unfocusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    unfocusNode ?? unfocusNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Material(
        color: Colors.transparent,
        elevation: 5,
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(0),
              bottomRight: Radius.circular(0),
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: SingleChildScrollView(
            child: StickyHeader(
              header: const SheetHeader(
                title: 'Add New',
              ),
              content: const SheetContent(),
            ),
          ),
        ),
      ),
    );
  }
}

class SheetContent extends StatefulWidget {
  const SheetContent({super.key});

  @override
  State<SheetContent> createState() => _SheetContentState();
}

class _SheetContentState extends State<SheetContent> {
  String type = "Debit";
  String category = "";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SegmentedButton<String>(
                      showSelectedIcon: false,
                      segments: const [
                        ButtonSegment(
                          value: "Debit",
                          label: RoomahText(
                            'Expenses',
                            textStyle: RoomahTextStyle.labelMedium,
                          ),
                        ),
                        ButtonSegment(
                          value: "Kredit",
                          label: RoomahText(
                            'Income',
                            textStyle: RoomahTextStyle.labelMedium,
                          ),
                        )
                      ],
                      selected: <String>{type},
                      onSelectionChanged: (Set<String> newSelection) {
                        setState(() {
                          type = newSelection.first;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const Gap(8),
              RoomahDropdown(
                options: const ['Option 1', 'Option 2', 'Option 3', 'Option 4'],
                onSelected: (value) {
                  setState(() {
                    category = value;
                  });
                },
              ),
              const Gap(8),
              RoomahTextField('Description', onChanged: (_) {}),
              const Gap(8),
              RoomahTextField(
                'Amount',
                isCurrency: true,
                inputType: TextInputType.phone,
                onChanged: (_) {},
              ),
              const Gap(8),
              RoomahDatePicker(
                'Date',
                datePicked: date,
                onSubmit: (newDate) => setState(() => date = newDate),
              ),
              const Gap(24),
              SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: const RoomahText(
                    'Save',
                    textStyle: RoomahTextStyle.labelMedium,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
