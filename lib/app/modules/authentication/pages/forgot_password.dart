import 'package:brillo_assessment/app/modules/authentication/provider/authentication_provider.dart';
import 'package:brillo_assessment/app/shared/functions/string_functions.dart';
import 'package:brillo_assessment/app/shared/widgets/button/back_button.dart';
import 'package:brillo_assessment/app/shared/widgets/button/custom_button.dart';
import 'package:brillo_assessment/app/shared/widgets/dialog/loading_dialog.dart';
import 'package:brillo_assessment/app/shared/widgets/input/custom_textfield.dart';
import 'package:brillo_assessment/app/shared/widgets/snackbar.dart/snack_bar.dart';
import 'package:brillo_assessment/core/config/navigation/navigation.dart';
import 'package:brillo_assessment/core/constants/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/widgets/text/base_text.dart';

class ForgotPassword extends HookConsumerWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState('');

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Padding(
          padding: screenPadding,
          child: SafeArea(
            child: ListView(
              children: [
                const Align(
                  alignment: Alignment.topLeft,
                  child: CustomBackButton(),
                ),
                const BaseText(
                  text: 'Forgot Password',
                  size: 20,
                  weight: FontWeight.w600,
                ),
                const YBox(10),
                const BaseText(
                  text: 'Enter your registered email address to\ncontinue.',
                  weight: FontWeight.w400,
                  color: Color.fromARGB(255, 118, 116, 116),
                ),
                const YBox(30),
                CustomTextField(
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) {
                    email.value = v;
                  },
                ),
                const YBox(40),
                CustomButton(
                  validator: () => isValidEmailAddress(email.value),
                  text: 'Proceed',
                  onPressed: () {
                    showLoader(context);
                    final p = ref.read(authRepo);
                    p.forgotPassword(
                      email.value,
                      onDone: (state) {
                        pop(context);
                        if (state.error) {
                          context.showError(state.message!);
                          return;
                        }
                        const c = 'A reset link has been sent to your email';
                        context.showSuccess(c);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
