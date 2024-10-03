import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../core/utils/utils.dart';
import '../helpers/helpers.dart';

part 'http_providers.g.dart';

@riverpod
HttpHelper planetApi(PlanetApiRef ref) {
  return HttpHelper(
    baseUrl: Env.baseUrl,
  );
}
