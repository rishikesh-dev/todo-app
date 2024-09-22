import 'package:flutter/material.dart';
import 'package:todo_app/Desktop/desktop_dashboard_page.dart';
import 'package:todo_app/Mobile/mobile_dashboard_page.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 700) {
          return const DesktopDashboardPage();
        } else {
          return const MobileDashboardPage();
        }
      },
    );
  }
}
