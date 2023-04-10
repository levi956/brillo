import 'package:brillo_assessment/app/modules/user_interests/provider/user_interest_provider.dart';
import 'package:brillo_assessment/app/shared/pages/dashboard/dashboard_page.dart';
import 'package:brillo_assessment/app/shared/widgets/button/back_button.dart';
import 'package:brillo_assessment/app/shared/widgets/button/custom_button.dart';
import 'package:brillo_assessment/app/shared/widgets/dialog/loading_dialog.dart';
import 'package:brillo_assessment/app/shared/widgets/snackbar.dart/snack_bar.dart';
import 'package:brillo_assessment/core/config/navigation/navigation.dart';
import 'package:brillo_assessment/core/constants/layout.dart';
import 'package:chips_choice/chips_choice.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../shared/widgets/text/base_text.dart';

class SelectInterest extends HookConsumerWidget {
  const SelectInterest({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = useState<List<String>>([]);
    final options = useState([
      '⚽️ Football',
      '🤾🏼‍♂️ Volleyball',
      '🏀 BasketBall',
      '⛸️ Skating',
      '🎾 Tennis',
      '🏓 Table Tennis',
    ]);

    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: ListView(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: CustomBackButton(),
            ),
            const BaseText(
              text: 'Which sport has your interest?',
              size: 20,
              weight: FontWeight.w600,
            ),
            const YBox(10),
            const BaseText(
              text: 'You can select multiple interests from list below',
              weight: FontWeight.w400,
              color: Color.fromARGB(255, 118, 116, 116),
            ),
            const YBox(30),
            ChipsChoice<String>.multiple(
              choiceStyle: C2ChipStyle(
                backgroundColor: Colors.grey.withOpacity(.6),
                foregroundStyle: Theme.of(context).textTheme.bodyMedium,
                checkmarkColor: Colors.black,
              ),
              choiceCheckmark: true,
              wrapped: true,
              value: tags.value,
              onChanged: (v) {
                tags.value = v;
              },
              choiceItems: C2Choice.listFrom<String, String>(
                source: options.value,
                value: (i, v) => v,
                label: (i, v) => v,
              ),
            ),
            const YBox(30),
            CustomButton(
              text: 'Continue',
              onPressed: () {
                showLoader(context);
                final p = ref.read(userInterestRepo);
                p.insertInterest(
                  tags.value,
                  onDone: (state) {
                    pop(context);
                    if (state.error) {
                      context.showError(state.message!);
                      return;
                    }
                    pushTo(context, const DashboardPage());
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
