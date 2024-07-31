import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AppPage extends StatefulWidget {
  const AppPage({super.key});

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roomah'),
      ),
      body: Center(
        child: Column(
          children: [
            const Gap(24),
            ElevatedButton(
              onPressed: () => context.pushNamed('financePage'),
              child: const Text('Finance'),
            ),
            const Gap(24),
            ElevatedButton(
              onPressed: () => context.pushNamed('notesPage'),
              child: const Text('Notes'),
            ),
          ],
        ),
      ),
    );
  }
}
