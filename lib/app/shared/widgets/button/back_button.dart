import 'package:flutter/material.dart';

import '../../../../core/config/navigation/navigation.dart';

class CustomBackButton extends StatelessWidget {
  const CustomBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: () => pop(context),
      icon: const Icon(
        Icons.keyboard_backspace,
        color: Colors.black,
      ),
    );
  }
}
