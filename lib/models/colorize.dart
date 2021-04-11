import 'package:http/http.dart' as http;

class Colorize {
  static const apiKey = '48c8563f-dcef-4b3b-94b0-d68bb1911a9a';
  static const api = 'https://api.deepai.org/api/colorizer ';
  final String bwImage;
  var colorizedImage;

  Colorize({this.bwImage});

  Future<void> colorizeimage() {
    return http.post(Uri.parse(api),
        headers: {'api-key': apiKey},
        body: {'image': bwImage}).then((response) => print(response.body));
  }
}
