// ignore_for_file: use_build_context_synchronously

import 'package:brillo_assessment/app/modules/settings/pages/settings_page.dart';
import 'package:brillo_assessment/app/shared/widgets/text/base_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';

import '../../../../core/config/device/bar_color.dart';
import '../../../modules/home/pages/homepage.dart';

class DashboardPage extends StatefulHookConsumerWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setStatusBarColor(color: BarColor.black);
    List<Widget> screens = [
      const HomePage(),
      SizedBox(
        child: _buildEmptyStatic(),
      ),
      SizedBox(
        child: _buildEmptyStatic(),
      ),
      const SettingsPage(),
    ];
    final pageIndex = useState(0);
    final scaffoldBacground = Theme.of(context).scaffoldBackgroundColor;
    const labelStyle = TextStyle(fontWeight: FontWeight.w400, fontSize: 12);
    return Scaffold(
      bottomNavigationBar: Container(
        color: scaffoldBacground,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: BottomNavigationBar(
            backgroundColor: scaffoldBacground,
            currentIndex: pageIndex.value,
            iconSize: 20,
            elevation: 0,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            selectedLabelStyle: labelStyle,
            unselectedLabelStyle: labelStyle,
            onTap: (v) {
              pageIndex.value = v;
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.user,
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.street_view,
                ),
                label: 'Buddies',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.binoculars,
                ),
                label: 'Discover',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  LineAwesomeIcons.user_cog,
                ),
                label: 'Settings',
              ),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: pageIndex.value,
        children: screens,
      ),
    );
  }
}

Widget _buildEmptyStatic() {
  return const Center(
    child: BaseText(
      text: 'Coming Soon!',
      size: 20,
    ),
  );
}
