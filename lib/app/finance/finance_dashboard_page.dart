import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:roomah/src/components/bottomsheet/create_transaction_sheet.dart';
import 'package:roomah/src/components/text/roomah_text.dart';

class FinanceDashboardPage extends StatefulWidget {
  const FinanceDashboardPage({super.key});

  @override
  State<FinanceDashboardPage> createState() => _FinanceDashboardPageState();
}

class _FinanceDashboardPageState extends State<FinanceDashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Financial'),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RoomahText(
                    'Balance',
                    textStyle: RoomahTextStyle.labelSmall,
                  ),
                  RoomahText(
                    'Rp1.200.123.123',
                    textStyle: RoomahTextStyle.labelLarge,
                  ),
                  Gap(24),
                ],
              ),
            ),
            SizedBox.expand(
              child: DraggableScrollableSheet(
                initialChildSize: 0.8, // Half screen
                minChildSize: 0.8, // Minimum size (half screen)
                maxChildSize: 1.0, // Maximum size (full screen)
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Container(
                    color: Colors.white,
                    child: ListView.builder(
                      controller: scrollController,
                      itemCount: 25,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RoomahText(
                                'Belanja sesuatu $index',
                                textStyle: RoomahTextStyle.labelMedium,
                              ),
                              const RoomahText(
                                'Ini deskripsi karena kamu sudah belanja sesuatu disini loh',
                                textStyle: RoomahTextStyle.labelSmall,
                              ),
                            ],
                          ),
                          trailing: const RoomahText(
                            'Rp120.000',
                            textStyle: RoomahTextStyle.labelMedium,
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            enableDrag: true,
            context: context,
            builder: (bottomSheetContext) {
              return const CreateTransactionSheet();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
