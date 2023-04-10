// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:brillo_assessment/app/modules/authentication/models/auth_models.dart';
import 'package:brillo_assessment/app/modules/authentication/pages/forgot_password.dart';
import 'package:brillo_assessment/app/modules/authentication/provider/authentication_provider.dart';
import 'package:brillo_assessment/app/shared/functions/string_functions.dart';
import 'package:brillo_assessment/app/shared/pages/dashboard/dashboard_page.dart';
import 'package:brillo_assessment/app/shared/widgets/button/custom_button.dart';
import 'package:brillo_assessment/app/shared/widgets/dialog/loading_dialog.dart';
import 'package:brillo_assessment/app/shared/widgets/input/custom_textfield.dart';
import 'package:brillo_assessment/app/shared/widgets/snackbar.dart/snack_bar.dart';
import 'package:brillo_assessment/app/shared/widgets/text/base_text.dart';
import 'package:brillo_assessment/core/config/navigation/navigation.dart';
import 'package:brillo_assessment/core/constants/layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/widgets/input/eye_visibility.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState(false);

    final _email = useState('');
    final _password = useState('');

    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: Padding(
          padding: screenPadding,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // add the back button here

                const YBox(30),

                const BaseText(
                  text: 'Login',
                  size: 20,
                  weight: FontWeight.w600,
                ),

                const YBox(10),

                const BaseText(
                  text: 'Enter your registered email address to\ncontinue.',
                  weight: FontWeight.w400,
                  color: Color.fromARGB(255, 118, 116, 116),
                ),

                const YBox(20),
                CustomTextField(
                  label: 'Email Address',
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (v) {
                    _email.value = v.trim();
                  },
                ),
                const YBox(20),

                CustomTextField(
                  label: 'Password',
                  isHidden: showPassword.value,
                  suffix: EyeVisibility(show: showPassword),
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (v) {
                    _password.value = v.trim();
                  },
                ),
                const YBox(5),
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                    onPressed: () => pushTo(context, const ForgotPassword()),
                    child: const BaseText(
                      text: 'Forgot Password?',
                    ),
                  ),
                ),
                const YBox(40),

                CustomButton(
                  buttonWidth: double.maxFinite,
                  text: 'Continue',
                  validator: () {
                    return isValidEmailAddress(_email.value);
                  },
                  onPressed: () {
                    showLoader(context);
                    final p = ref.read(authRepo);
                    p.login(
                      LoginModel(
                        _email.value,
                        _password.value,
                      ),
                      onDone: (state) {
                        pop(context);
                        if (state.error) {
                          context.showError(state.message!);
                          return;
                        }
                        const page = DashboardPage();
                        pushTo(context, page);
                      },
                    );
                  },
                ),

                const YBox(50),

                const Center(
                  child: BaseText(text: 'or'),
                ),

                const YBox(50),

                GestureDetector(
                  onTap: () {},
                  child: const Center(
                    child: BaseText(
                      text: 'Continue with phone number',
                      color: Colors.grey,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
