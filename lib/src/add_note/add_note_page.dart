import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class AddNotePage extends StatelessWidget {
  const AddNotePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Get today's date in mm-dd-yyyy format
    final String appBarTitle = DateFormat('MM-dd-yyyy').format(DateTime.now());

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Add your save functionality here
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Note saved!')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: TextField(
                maxLines: null, // Allows unlimited lines
                expands: true, // Expands to fill available space
                keyboardType: TextInputType.multiline,
                textAlignVertical: TextAlignVertical.top, // Aligns text to the top
                decoration: InputDecoration(
                  hintText: 'Enter your note here...',
                  border: null,
                  contentPadding: EdgeInsets.all(4.0),
                ),
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}