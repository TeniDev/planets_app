import 'package:envied/envied.dart';

import '../constants/constants.dart';

part 'env.g.dart';

@Envied(path: '.env')
abstract class Env {
  @EnviedField(varName: EnvConstants.baseUrl, obfuscate: true)
  static final String baseUrl = _Env.baseUrl;
}
