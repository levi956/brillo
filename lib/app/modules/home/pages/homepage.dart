import 'package:brillo_assessment/app/modules/authentication/service/authentication_service.dart';
import 'package:brillo_assessment/app/modules/home/provider/trends_provider.dart';

import 'package:brillo_assessment/core/constants/layout.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../shared/widgets/dialog/loading_dialog.dart';
import '../../../shared/widgets/text/base_text.dart';
import '../../user_interests/provider/user_interest_provider.dart';
import '../models/news_model.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final interest = ref.watch(userInterestProvider);
    final trends = ref.watch(latestTrendsProvider);

    return Scaffold(
      body: Padding(
        padding: screenPadding,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const YBox(10),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BaseText(
                        text: 'Hey, ${user!.userMetadata!['username'] ?? ''}',
                        size: 18,
                        weight: FontWeight.w600,
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(LineAwesomeIcons.user_circle),
                ],
              ),
              const YBox(30),
              const BaseText(
                text: 'What\'s new',
                weight: FontWeight.w600,
                size: 19,
              ),
              const YBox(10),
              Container(
                width: double.maxFinite,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(.3),
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  children: [
                    Image.asset('assets/images/painting.png'),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          YBox(10),
                          BaseText(
                            text: '- Connect with people.',
                            size: 13,
                          ),
                          YBox(5),
                          BaseText(
                            text: '- Join sport games.',
                            size: 13,
                          ),
                          YBox(5),
                          BaseText(
                            text: '- Host a sport game.',
                            size: 13,
                          ),
                          YBox(5),
                          BaseText(
                            text: '- Win local awards',
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const YBox(30),
              const BaseText(
                text: 'Your interests',
                weight: FontWeight.w600,
                size: 19,
              ),
              const YBox(10),
              interest.when(
                data: (data) {
                  if (data.error) {
                    return BaseText(text: data.message!);
                  }
                  final interest = data.data!;
                  if (interest.isEmpty) {}
                  return SizedBox(
                    height: 45,
                    width: double.maxFinite,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: interest.length,
                      separatorBuilder: (_, index) => const XBox(10),
                      itemBuilder: (_, index) {
                        final data = interest[index].sportInterest;
                        return CustomChip(data);
                      },
                    ),
                  );
                },
                error: (_, __) => BaseText(text: __.toString()),
                loading: loading,
              ),
              const YBox(50),
              const BaseText(
                text: 'Latest Trends',
                weight: FontWeight.w600,
                size: 19,
              ),
              const YBox(10),
              trends.when(
                data: (data) {
                  if (data.error) {
                    return BaseText(text: data.message!);
                  }
                  final trends = data.data!;
                  if (trends.isEmpty) {}
                  return SizedBox(
                    height: 120,
                    width: double.maxFinite,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      scrollDirection: Axis.horizontal,
                      itemCount: trends.length,
                      separatorBuilder: (_, index) => const XBox(20),
                      itemBuilder: (_, index) {
                        final data = trends[index];
                        return NewsCard(data);
                      },
                    ),
                  );
                },
                error: (_, __) => BaseText(text: __.toString()),
                loading: loading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final NewsModel model;
  const NewsCard(this.model, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(11),
      width: 200,
      decoration: BoxDecoration(
        color: Colors.grey.withOpacity(.4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BaseText(
            text: model.title!,
          ),
        ],
      ),
    );
  }
}

class CustomChip extends StatelessWidget {
  final String label;
  const CustomChip(this.label, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.grey.withOpacity(.4),
      ),
      child: BaseText(text: label),
    );
  }
}
