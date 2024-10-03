import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:planets_app/core/extensions/extensions.dart';
import 'package:planets_app/features/planets/providers/planets_provider.dart';
import 'package:planets_app/gen/assets.gen.dart';

import '../widgets/planet_tablet_card.dart';
import '../widgets/search_planets_tablet_field.dart';

class PlanetsListTabletView extends StatelessWidget {
  const PlanetsListTabletView({super.key});

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
            return Text(
              loading ? context.locale.planets_loading : context.locale.planets_explore,
              style: const TextStyle(
                fontSize: 36,
              ),
            );
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

                return Center(
                  child: Text(
                    context.locale.no_planets_found,
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                    ),
                  ),
                );
              }

              return Column(
                children: [
                  const SizedBox(height: 16),
                  const SearchPlanetsTabletField(),
                  const SizedBox(height: 24),
                  Expanded(
                    child: filteredPlanets != null && filteredPlanets.isEmpty
                        ? Center(
                            child: Text(
                              '${context.locale.no_planets_found}' '\n${context.locale.try_another_search}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 16,
                              mainAxisSpacing: 16,
                              childAspectRatio: (1 / .3),
                            ),
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

                              return PlanetTabletCard(
                                planet: planet,
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
