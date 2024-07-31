import 'package:flutter/material.dart';

class NotesListPage extends StatefulWidget {
  const NotesListPage({super.key});

  @override
  State<NotesListPage> createState() => _NotesListPageState();
}

class _NotesListPageState extends State<NotesListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Roomah'),
      ),
      body: const Center(
        child: Text('Notes Page'),
      ),
    );
  }
}
