import 'package:brillo_assessment/app/modules/authentication/pages/login.dart';
import 'package:brillo_assessment/app/modules/authentication/pages/signup.dart';
import 'package:brillo_assessment/app/modules/authentication/service/authentication_service.dart';
import 'package:brillo_assessment/app/shared/widgets/button/custom_button.dart';
import 'package:brillo_assessment/app/shared/widgets/text/base_text.dart';
import 'package:brillo_assessment/core/config/device/bar_color.dart';
import 'package:brillo_assessment/core/config/navigation/navigation.dart';
import 'package:brillo_assessment/core/constants/layout.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Onboard extends HookConsumerWidget {
  const Onboard({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    setStatusBarColor(color: BarColor.black);

    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YBox(100),
              Center(
                child: Image.asset(
                  'assets/images/onboard.png',
                  width: 240,
                  height: 240,
                ),
              ),
              const Spacer(),
              const BaseText(
                text: _head,
                weight: FontWeight.w600,
                size: 20,
              ),
              const YBox(10),
              const BaseText(
                text: _sub,
              ),
              const YBox(30),
              Row(
                children: [
                  Expanded(
                    child: CustomButton(
                      text: 'Get Started',
                      onPressed: () {
                        ref.invalidate(userProvider);
                        const page = SignUpPage();
                        pushTo(context, page);
                      },
                    ),
                  ),
                  const XBox(20),
                  Expanded(
                    child: CustomButtonOutlined(
                      text: 'Login',
                      borderSideColor: Colors.black,
                      textColor: Colors.black,
                      onPressed: () {
                        const page = LoginPage();
                        pushTo(context, page);
                      },
                    ),
                  ),
                ],
              ),
              const YBox(30),
            ],
          ),
        ),
      ),
    );
  }
}

const _head = 'Find your sporting rival! ⚽️';
const _sub =
    'Ian is the easiest and safest place to\nconnect and share your favorite sporting\ninterests.';
