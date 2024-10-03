import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class ResponsiveWidget extends StatelessWidget {
  const ResponsiveWidget({
    super.key,
    required this.child,
  });

  final Widget Function(Size, ResponsiveSizes) child;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final responsiveSizes = ResponsiveSizes();

    return child(
      size,
      responsiveSizes,
    );
  }
}
