import 'package:brillo_assessment/core/constants/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../text/base_text.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final bool? isHidden;
  final String? hintText;
  final Widget? prefixIcon;
  final bool? readOnly;
  final TextStyle? hintStyle;
  final int? maxLength;
  final Function()? onTap;
  final bool? enabled;

  final Widget? suffix;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    required this.label,
    this.hintText,
    this.controller,
    this.onTap,
    this.keyboardType,
    this.enabled,
    this.maxLength,
    this.isHidden,
    this.hintStyle,
    this.onChanged,
    this.prefixIcon,
    this.readOnly,
    this.inputFormatters,
    this.suffix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color grey3 = const Color(0xFFF9FAFB);
    Color borderSide = const Color(0xFFCFD1D1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: label,
          size: 12,
        ),
        const YBox(10),
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
          child: TextField(
            onTap: onTap,
            enabled: enabled,
            maxLength: maxLength,
            controller: controller,
            readOnly: readOnly ?? false,
            autocorrect: false,
            style:
                Theme.of(context).textTheme.bodyMedium!.copyWith(fontSize: 14),
            inputFormatters: inputFormatters,
            obscureText: isHidden ?? false,
            cursorColor: Colors.black,
            keyboardType: keyboardType,
            onChanged: onChanged,
            decoration: InputDecoration(
              suffixIcon: suffix ?? const SizedBox.shrink(),
              prefixIcon: prefixIcon,
              isDense: true,
              contentPadding: const EdgeInsets.all(13),
              floatingLabelBehavior: FloatingLabelBehavior.never,
              fillColor: Colors.grey.withOpacity(.1),
              filled: true,
              focusColor: grey3,
              labelText: hintText ?? '',
              hintStyle: hintStyle,
              labelStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 14,
                    color: Colors.black,
                  ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide: const BorderSide(color: Colors.black, width: 1.9),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide:
                    const BorderSide(color: Color(0xFFCCCCCC), width: 1.0),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(1),
                borderSide:
                    const BorderSide(color: Color(0xFFCCCCCC), width: 1.0),
              ),
              errorBorder: OutlineInputBorder(
                gapPadding: 2,
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: borderSide),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }
    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}

class OnlyNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final newValueString = newValue.text;
    String valueToReturn = '';

    for (int i = 0; i < newValueString.length; i++) {
      if (newValueString[i] != ' ') valueToReturn += newValueString[i];

      if (!(newValueString[i] == ' ' ||
          newValueString[i] == '0' ||
          newValueString[i] == '1' ||
          newValueString[i] == '2' ||
          newValueString[i] == '3' ||
          newValueString[i] == '4' ||
          newValueString[i] == '5' ||
          newValueString[i] == '6' ||
          newValueString[i] == '7' ||
          newValueString[i] == '8' ||
          newValueString[i] == '9')) {
        valueToReturn = valueToReturn.substring(0, valueToReturn.length - 1);
      }
    }
    return newValue.copyWith(
      text: valueToReturn,
      selection: TextSelection.fromPosition(
        TextPosition(offset: valueToReturn.length),
      ),
    );
  }
}

// exclude decimal number formatter
class NoDecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Only allow digits (0-9)
    if (newValue.text.contains('.')) {
      return oldValue;
    }
    return newValue;
  }
}
