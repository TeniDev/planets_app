part of 'router.dart';

Page<Widget> _homeHandler(BuildContext context, GoRouterState state) {
  return const NoTransitionPage(
    child: HomePage(),
  );
}

Page<dynamic> _planetsHandler(BuildContext context, GoRouterState state) {
  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 800),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    child: const PlanetsListPage(),
  );
}

Page<Widget> _planetDetailHandler(BuildContext context, GoRouterState state) {
  final id = state.pathParameters['planet'];

  return CustomTransitionPage(
    transitionDuration: const Duration(milliseconds: 650),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    child: PlanetsDetailsPage(
      idPlanet: id,
    ),
  );
}
