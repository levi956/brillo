// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:brillo_assessment/app/modules/authentication/models/auth_models.dart';
import 'package:brillo_assessment/app/modules/authentication/provider/authentication_provider.dart';
import 'package:brillo_assessment/app/modules/user_interests/pages/select_interest.dart';
import 'package:brillo_assessment/app/shared/functions/string_functions.dart';
import 'package:brillo_assessment/app/shared/widgets/button/back_button.dart';
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

class SignUpPage extends HookConsumerWidget {
  const SignUpPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showPassword = useState(false);

    final _email = useState('');
    final _password = useState('');
    final _username = useState('');
    final _phone = useState('');
    final _name = useState('');

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
                  text: 'Register',
                  size: 20,
                  weight: FontWeight.w600,
                ),
                const YBox(10),
                const BaseText(
                  text:
                      'Enter your credentails to get your account\n up and running.',
                  weight: FontWeight.w400,
                  color: Color.fromARGB(255, 118, 116, 116),
                ),
                const YBox(20),
                CustomTextField(
                  label: 'Full Name',
                  keyboardType: TextInputType.name,
                  onChanged: (v) {
                    _name.value = v.trim();
                  },
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
                  label: 'Username',
                  keyboardType: TextInputType.name,
                  onChanged: (v) {
                    _username.value = v.trim();
                  },
                ),
                const YBox(20),
                CustomTextField(
                  label: 'Phone',
                  keyboardType: TextInputType.phone,
                  inputFormatters: [OnlyNumberFormatter()],
                  onChanged: (v) {
                    _phone.value = v.trim();
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
                    final model = RegisterModel(
                      _email.value,
                      _name.value,
                      _password.value,
                      _phone.value,
                      _username.value,
                    );
                    p.signUp(
                      model,
                      onDone: (state) {
                        if (state.error) {
                          pop(context);
                          context.showError(state.message!);
                          return;
                        }
                        p.insertUser(
                          model,
                          onDone: (state) {
                            pop(context);
                            if (state.error) {
                              context.showError(state.message!);
                              print(state.message);
                              return;
                            }
                            const page = SelectInterest();
                            pushTo(context, page);
                          },
                        );
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
