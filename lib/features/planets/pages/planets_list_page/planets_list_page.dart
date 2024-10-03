import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import 'desktop/planet_list_desktop.dart';
import 'mobile/planet_list_mobile.dart';
import 'tablet/planet_list_tablet.dart';

class PlanetsListPage extends BasePage {
  const PlanetsListPage({super.key});

  @override
  Widget? mobileBody() {
    return const PlanetListMobileView();
  }

  @override
  Widget? tabletBody() {
    return const PlanetsListTabletView();
  }

  @override
  Widget? desktopBody() {
    return const PlanetsListDesktopView();
  }
}
