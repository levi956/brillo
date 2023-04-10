import 'dart:io';

import 'package:flutter/material.dart';

void showLoader(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => Center(
      child: SizedBox(
        height: 20,
        width: 20,
        child: (Platform.isIOS)
            ? const CircularProgressIndicator.adaptive()
            : const CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Colors.black,
              ),
      ),
    ),
  );
}

Center loading() {
  return Center(
    child: SizedBox(
      height: 20,
      width: 20,
      child: (Platform.isIOS)
          ? const CircularProgressIndicator.adaptive()
          : const CircularProgressIndicator(
              strokeWidth: 2.0,
              color: Colors.black,
            ),
    ),
  );
}
