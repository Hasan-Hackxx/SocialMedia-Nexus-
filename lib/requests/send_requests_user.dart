import 'dart:convert';

import 'package:http/http.dart' as http;

class SendRequestsUser {
  String url =
      'https://hcvvwt21-5678.use2.devtunnels.ms/webhook-test/Nexus/socialMedia';

  Future<String?> sendRequests(
    String userPrompt,
    String platform,
    String kind,
  ) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'x-Skip-Publisher-Check': 'true',
        },

        body: jsonEncode({
          'prompt': userPrompt,
          'platform': platform,
          'kind': kind,
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);

        return data['output'].toString();
      } else {
        print('Erorr in connection');
      }
    } catch (e) {
      print(e);
    }
    return '';
  }
}
