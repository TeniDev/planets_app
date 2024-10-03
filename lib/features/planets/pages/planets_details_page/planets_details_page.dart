import 'package:flutter/material.dart';

import '../../../../core/widgets/widgets.dart';
import 'desktop/planet_detail_desktop.dart';
import 'mobile/planet_detail_mobile.dart';
import 'tablet/planet_detail_tablet.dart';

class PlanetsDetailsPage extends BasePage {
  const PlanetsDetailsPage({
    super.key,
    required this.idPlanet,
  });

  final String? idPlanet;

  @override
  Widget? mobileBody() {
    return PlanetDetailMobileView(
      idPlanet: idPlanet,
    );
  }

  @override
  Widget? tabletBody() {
    return PlanetDetailTabletView(
      idPlanet: idPlanet,
    );
  }

  @override
  Widget? desktopBody() {
    return PlanetDetailDesktopView(
      idPlanet: idPlanet,
    );
  }
}
