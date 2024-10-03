import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:planets_app/gen/assets.gen.dart';

import '../widgets/welcome_widget_desktop.dart';

class HomePageDesktop extends StatelessWidget {
  const HomePageDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: Stack(
        children: [
          FadeInLeft(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  alignment: Alignment.centerLeft,
                  image: AssetImage(
                    Assets.images.astronaut.path,
                  ),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.6),
                  Colors.black.withOpacity(1),
                ],
                stops: const [0.1, .3, .5],
              ),
            ),
          ),
          const WelcomeWidgetDesktop(),
        ],
      ),
    );
  }
}
