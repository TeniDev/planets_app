import 'package:http/http.dart' as http;

class HttpHelper {
  HttpHelper({
    required String baseUrl,
  }) : _base = baseUrl;

  final String _base;

  Future<http.Response> get(
    String path, {
    Map<String, String>? queryParameters,
    Map<String, String>? headers,
  }) async {
    final uri = Uri.parse('$_base/$path').replace(
      queryParameters: queryParameters,
    );

    final response = await http.get(
      uri,
      headers: headers,
    );

    return response;
  }
}
