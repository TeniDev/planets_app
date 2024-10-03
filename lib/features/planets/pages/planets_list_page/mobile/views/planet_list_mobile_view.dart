import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/gen/assets.gen.dart';

import '../../../../providers/planets_provider.dart';
import '../widgets/planet_mobile_card.dart';
import '../widgets/search_planets_mobile_field.dart';

class PlanetListMobileView extends StatelessWidget {
  const PlanetListMobileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBody: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Consumer(
          builder: (_, ref, __) {
            final loading = ref.watch(planetsProvider.select((state) => state.isLoading));
            return Text(loading ? 'Loading...' : 'Explore Planets');
          },
        ),
      ),
      body: Stack(
        children: [
          FadeInUp(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                      Assets.images.background.path,
                    ),
                    fit: BoxFit.cover,
                    opacity: .6),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withOpacity(0.94),
                  Colors.black.withOpacity(0.5),
                  Colors.black.withOpacity(0.3),
                ],
                stops: const [0.1, .3, .6],
              ),
            ),
          ),
          Consumer(
            builder: (_, ref, __) {
              final loading = ref.watch(planetsProvider.select((state) => state.isLoading));
              final planets = ref.watch(planetsProvider.select((state) => state.planets));
              final filteredPlanets = ref.watch(planetsProvider.select((state) => state.filteredPlanets));

              if (planets == null) {
                if (loading) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    ref.read(planetsProvider.notifier).getAllPlanets();
                  });

                  return const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  );
                }

                return const Center(
                  child: Text(
                    'No planets found',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 16),
                  const SearchPlanetsMobileField(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: filteredPlanets != null && filteredPlanets.isEmpty
                        ? const Center(
                            child: Text(
                              'No planets found' '\nTry another search',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                            ),
                            shrinkWrap: true,
                            itemCount: filteredPlanets != null && filteredPlanets.isNotEmpty
                                ? filteredPlanets.length
                                : planets.length,
                            itemBuilder: (_, index) {
                              final planetsList =
                                  filteredPlanets != null && filteredPlanets.isNotEmpty ? filteredPlanets : planets;
                              final planet = planetsList[index];

                              return PlanetMobileCard(
                                planet: planet,
                                isLast: index == planets.length - 1,
                              );
                            },
                          ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
