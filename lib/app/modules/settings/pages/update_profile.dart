// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:brillo_assessment/app/shared/widgets/snackbar.dart/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/navigation/navigation.dart';
import '../../../../core/constants/layout.dart';
import '../../../shared/functions/string_functions.dart';
import '../../../shared/widgets/button/back_button.dart';
import '../../../shared/widgets/button/custom_button.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../../shared/widgets/input/custom_textfield.dart';
import '../../../shared/widgets/text/base_text.dart';
import '../../authentication/provider/authentication_provider.dart';

enum Field { username, password, email }

class UpdateProfile extends HookConsumerWidget {
  final Field type;
  const UpdateProfile({
    super.key,
    required this.type,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _updatedData = useState('');

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
                BaseText(
                  text: 'Update ${type.name}',
                  size: 20,
                  weight: FontWeight.w600,
                ),
                const YBox(10),
                BaseText(
                  text: 'Enter your updated ${type.name} in the field below.',
                  weight: FontWeight.w400,
                  color: const Color.fromARGB(255, 118, 116, 116),
                ),
                const YBox(30),
                CustomTextField(
                  label: 'New ${type.name}',
                  keyboardType: type == Field.password
                      ? TextInputType.visiblePassword
                      : TextInputType.emailAddress,
                  onChanged: (v) {
                    _updatedData.value = v;
                  },
                ),
                const YBox(40),
                CustomButton(
                  validator: () => type == Field.email
                      ? isValidEmailAddress(_updatedData.value)
                      : true,
                  text: 'Proceed',
                  onPressed: () {
                    showLoader(context);
                    final p = ref.read(authRepo);

                    if (type == Field.email) {
                      p.updateEmail(
                        _updatedData.value,
                        onDone: (state) {
                          pop(context);
                          if (state.error) {
                            context.showError(state.message!);
                            return;
                          }
                          const c = 'Email Address updated';
                          context.showSuccess(c);
                        },
                      );
                      return;
                    }
                    if (type == Field.password) {
                      p.updatePassword(
                        _updatedData.value,
                        onDone: (state) {
                          pop(context);
                          if (state.error) {
                            context.showError(state.message!);
                            return;
                          }
                          const c = 'Password updated';
                          context.showSuccess(c);
                        },
                      );
                      return;
                    }
                    if (type == Field.username) {
                      p.updateUsername(
                        _updatedData.value,
                        onDone: (state) {
                          pop(context);
                          if (state.error) {
                            context.showError(state.message!);
                            return;
                          }
                          const c = 'Username updated';
                          context.showSuccess(c);
                        },
                      );
                      return;
                    }
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
