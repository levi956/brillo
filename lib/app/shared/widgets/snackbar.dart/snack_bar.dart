import 'package:flutter/material.dart';

extension Extras on BuildContext {
  void _showSnackBar(
    String message, {
    Color? color,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Container(
          width: 200,
          decoration: BoxDecoration(
            color: color ?? Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                const Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                Text(
                  message,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }

  void showError(String message) {
    _showSnackBar(
      message,
      color: const Color(0xFFC41E3A),
    );
  }

  void showSuccess(String message) {
    _showSnackBar(message, color: Colors.green);
  }
}
