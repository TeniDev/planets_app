import 'package:flutter/material.dart';
import 'package:planets_app/core/extensions/extensions.dart';

import '../../utils/utils.dart';

abstract class BasePage extends StatelessWidget {
  const BasePage({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveSizes = ResponsiveSizes();

    if (screenWidth < 768) {
      return mobileBody() ?? const _BaseWidget();
    } else if (screenWidth < responsiveSizes.desktopHD) {
      return tabletBody() ?? const _BaseWidget();
    } else {
      return desktopBody() ?? const _BaseWidget();
    }
  }

  Widget? mobileBody() => null;
  Widget? tabletBody() => null;
  Widget? desktopBody() => null;
}

class _BaseWidget extends StatelessWidget {
  const _BaseWidget();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          height: size.height,
          width: size.width,
          child: Center(
            child: Text(context.locale.comingSoon),
          ),
        ),
      ),
    );
  }
}
