import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? buttonTextColor;
  final double? buttonWidth;
  final Color? buttonColor;
  final double? fontSize;
  final FontWeight? buttonTextWeight;
  final bool Function()? validator;

  const CustomButton(
      {required this.text,
      required this.onPressed,
      this.buttonWidth,
      this.buttonTextColor,
      this.validator,
      this.buttonTextWeight,
      this.buttonColor,
      this.fontSize,
      Key? key})
      : super(key: key);

  final double borderRadius = 3;

  @override
  Widget build(BuildContext context) {
    final phoneSize = MediaQuery.of(context).size;
    return Container(
      height: 50,
      width: buttonWidth ?? phoneSize.width * 0.65,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: (validator == null ? true : validator!())
            ? buttonColor ?? Colors.black
            : Colors.blueGrey,
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(
            const EdgeInsets.only(top: 9, bottom: 9),
          ),
          backgroundColor: MaterialStateProperty.all(Colors.transparent),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
        ),
        onPressed: (validator == null ? true : validator!()) ? onPressed : null,
        child: Text(
          text,
          style: TextStyle(
            color: buttonTextColor ?? Colors.white,
            fontSize: fontSize ?? 14,
            fontWeight: buttonTextWeight ?? FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class CustomButtonOutlined extends ConsumerWidget {
  final String text;
  final Color? textColor;
  final VoidCallback onPressed;
  final double? buttonWidth;
  final Color? borderSideColor;
  const CustomButtonOutlined({
    super.key,
    required this.text,
    this.textColor,
    this.buttonWidth,
    this.borderSideColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final phoneSize = MediaQuery.of(context).size;
    return SizedBox(
      height: 50,
      width: buttonWidth ?? phoneSize.width * 0.65,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(3),
            ),
          ),
          side: BorderSide(
            color: borderSideColor ?? const Color(0xFFFF0033),
            width: 1.4,
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: textColor ?? const Color(0xFFFF0033),
          ),
        ),
      ),
    );
  }
}
