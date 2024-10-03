part of 'router.dart';

class RoutesNames {
  static const String home = '/home';
  static const String planets = '/planets';
  static const String planetDetail = '/planets/:planet';

  static List<String> toList() {
    return [home, planets, planetDetail];
  }
}
