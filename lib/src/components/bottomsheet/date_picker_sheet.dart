import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:roomah/src/components/text/roomah_text.dart';
import 'package:roomah/src/res/colors.dart';

class DatePickerSheet extends StatefulWidget {
  final DateTime? initialDate;

  const DatePickerSheet({super.key, this.initialDate});

  @override
  DatePickerSheetState createState() => DatePickerSheetState();
}

class DatePickerSheetState extends State<DatePickerSheet> {
  FixedExtentScrollController? dayScrollController;
  FixedExtentScrollController? monthScrollController;
  FixedExtentScrollController? yearScrollController;

  static const int minimumAge = 0;

  List<int> listDays = List.generate((31 - 1) + 1, (index) => 1 + index);
  List<int> listMonths = List.generate((12 - 1) + 1, (index) => 1 + index);
  List<int> listYears = List.generate(
      (DateTime.now().year - 1940 - minimumAge) + 1, (index) => 1940 + index);

  int selectedDayIndex = 0;
  int selectedMonthIndex = 0;
  int selectedYearIndex = 0;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.initialDate != null) {
      selectedDate = widget.initialDate!;
    }

    selectedDayIndex = selectedDate.day - 1;
    selectedMonthIndex = selectedDate.month - 1;
    selectedYearIndex = selectedDate.year - 1940;

    dayScrollController =
        FixedExtentScrollController(initialItem: selectedDayIndex);
    monthScrollController =
        FixedExtentScrollController(initialItem: selectedMonthIndex);
    yearScrollController =
        FixedExtentScrollController(initialItem: selectedYearIndex);
  }

  @override
  void setState(VoidCallback fn) {
    super.setState(fn);
    adjustDateSlider();
  }

  @override
  void dispose() {
    super.dispose();
  }

  adjustDateSlider() {
    int year = listYears[yearScrollController!.selectedItem];

    //If selected Year equals to minum age permitted
    if (year == DateTime.now().year - minimumAge) {
      listMonths = List.generate(DateTime.now().month, (index) => 1 + index);
      if (selectedMonthIndex + 1 > listMonths.length) {
        monthScrollController!.jumpToItem(DateTime.now().month - 1);
      }
    } else {
      listMonths = List.generate((12 - 1) + 1, (index) => 1 + index);
    }

    int month = listMonths[monthScrollController!.selectedItem];
    if (year == DateTime.now().year - minimumAge &&
        month == DateTime.now().month) {
      listDays = List.generate(DateTime.now().day, (index) => 1 + index);
      if (selectedDayIndex + 1 > listDays.length) {
        dayScrollController!.jumpToItem(listDays.length);
      }
    } else {
      var maxDateOfYearAndMonth = DateTime(year, month + 1, 0);
      listDays = List.generate(
          (maxDateOfYearAndMonth.day - 1) + 1, (index) => 1 + index);
      if (selectedDayIndex + 1 > listDays.length) {
        dayScrollController!.jumpToItem(listDays.length);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      elevation: 5,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0),
          bottomRight: Radius.circular(0),
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 1,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(0),
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
                      Icons.arrow_back_rounded,
                      size: 24,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const RoomahText(
                    'Date',
                    textStyle: RoomahTextStyle.labelMedium,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 24),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Row(
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              const CenterIndicator(),
                              ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                perspective: 0.0001,
                                onSelectedItemChanged: (index) {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectedDayIndex = index;
                                  });
                                },
                                physics: const FixedExtentScrollPhysics(),
                                controller: dayScrollController,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: listDays.length,
                                  builder: (context, index) {
                                    return Center(
                                      child: RoomahText(
                                        listDays[index].toString(),
                                        textStyle: RoomahTextStyle.labelMedium,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Stack(
                            children: [
                              const CenterIndicator(),
                              ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                perspective: 0.0001,
                                onSelectedItemChanged: (index) {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectedMonthIndex = index;
                                  });
                                },
                                physics: const FixedExtentScrollPhysics(),
                                controller: monthScrollController,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: listMonths.length,
                                  builder: (context, index) {
                                    return Center(
                                      child: RoomahText(
                                        DateFormat('MMMM').format(
                                            DateTime(0, listMonths[index])),
                                        textStyle: RoomahTextStyle.labelMedium,
                                      ),
                                    );
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: [
                              const CenterIndicator(),
                              ListWheelScrollView.useDelegate(
                                itemExtent: 40,
                                perspective: 0.0001,
                                onSelectedItemChanged: (index) {
                                  HapticFeedback.lightImpact();
                                  setState(() {
                                    selectedYearIndex = index;
                                  });
                                },
                                physics: const FixedExtentScrollPhysics(),
                                controller: yearScrollController,
                                childDelegate: ListWheelChildBuilderDelegate(
                                  childCount: listYears.length,
                                  builder: (context, index) {
                                    return Center(
                                      child: RoomahText(
                                        listYears[index].toString(),
                                        textStyle: RoomahTextStyle.labelMedium,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(16, 32, 16, 16),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  child: const RoomahText(
                    'Next',
                    textStyle: RoomahTextStyle.labelMedium,
                  ),
                  onPressed: () {
                    Navigator.pop(
                      context,
                      DateTime(
                        listYears[selectedYearIndex],
                        listMonths[selectedMonthIndex],
                        listDays[selectedDayIndex],
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CenterIndicator extends StatelessWidget {
  const CenterIndicator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Center(
        child: Container(
          height: 48,
          width: double.infinity,
          decoration: const BoxDecoration(color: Colors.transparent),
          child: Column(
            children: [
              Container(
                height: 1,
                width: double.infinity,
                decoration: const BoxDecoration(color: RoomahColors.primary),
              ),
              const Expanded(child: SizedBox()),
              Container(
                height: 1,
                width: double.infinity,
                decoration: const BoxDecoration(color: RoomahColors.primary),
              )
            ],
          ),
        ),
      ),
    );
  }
}
