import 'package:flutter/material.dart';

void getErrorDailog(context) {
  Future.delayed(Duration.zero, () {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text(
            'No internet connection. Please check your internet connection and try again.'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  });
}
