import 'package:brillo_assessment/app/modules/authentication/service/authentication_service.dart';
import 'package:brillo_assessment/app/modules/settings/pages/update_profile.dart';
import 'package:brillo_assessment/app/shared/widgets/snackbar.dart/snack_bar.dart';
import 'package:brillo_assessment/app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/config/navigation/navigation.dart';
import '../../../../core/constants/layout.dart';
import '../../../shared/pages/onboard/onboard.dart';
import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../authentication/provider/authentication_provider.dart';

class SettingsPage extends StatefulHookConsumerWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YBox(20),
              const BaseText(
                text: 'Settings',
                size: 20,
                weight: FontWeight.w600,
              ),
              const YBox(30),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: user!.userMetadata!['name'] ?? '',
                        size: 16,
                      ),
                      BaseText(
                        text: user.userMetadata!['username'] ?? '',
                        size: 16,
                      ),
                    ],
                  ),
                ],
              ),
              const YBox(40),
              Expanded(
                child: ListView(
                  children: [
                    _settingsTile(
                      label: 'Update Email',
                      description: 'Change your account email',
                      onTap: () => pushTo(
                          context, const UpdateProfile(type: Field.email)),
                    ),
                    _settingsTile(
                      label: 'Change Password',
                      description: 'Change your account password',
                      onTap: () => pushTo(
                          context, const UpdateProfile(type: Field.password)),
                    ),
                    _settingsTile(
                      label: 'Update Username',
                      description: 'Change your account username',
                      onTap: () => pushTo(
                          context, const UpdateProfile(type: Field.username)),
                    ),
                    _settingsTile(
                      label: 'Logout',
                      description: '',
                      onTap: () {
                        showLoader(context);
                        final p = ref.read(authRepo);
                        p.logout(
                          onDone: (state) async {
                            if (state.error) {
                              context.showError(state.message!);
                              return;
                            }
                            await pushToAndClearStack(context, const Onboard());
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

GestureDetector _settingsTile({
  required VoidCallback onTap,
  required String label,
  required String description,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: double.maxFinite,
      height: 64,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF5F9FF),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          const XBox(15.33),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BaseText(
                text: label,
                size: 14,
              ),
              const YBox(3),
              BaseText(
                text: description,
                size: 14,
                color: Colors.grey,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
