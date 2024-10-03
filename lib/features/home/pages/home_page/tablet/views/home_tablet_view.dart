import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:planets_app/gen/assets.gen.dart';

import '../widgets/welcome_widget_tablet.dart';

class HomePageTablet extends StatelessWidget {
  const HomePageTablet({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      body: Stack(
        children: [
          FadeInDown(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    Assets.images.astronaut.path,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                  Colors.black.withOpacity(0.94),
                ],
                stops: const [0.1, .3, .65],
              ),
            ),
          ),
          const WelcomeWidgetTablet(),
        ],
      ),
    );
  }
}
