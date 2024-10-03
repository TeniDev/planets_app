import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import 'desktop/home_page_desktop.dart';
import 'mobile/home_page_mobile.dart';
import 'tablet/home_page_tablet.dart';

class HomePage extends BasePage {
  const HomePage({super.key});

  @override
  Widget? mobileBody() {
    return const HomePageMobile();
  }

  @override
  Widget? tabletBody() {
    return const HomePageTablet();
  }

  @override
  Widget? desktopBody() {
    return const HomePageDesktop();
  }
}
