import 'package:http/http.dart' as http;

class Network {
  static String _url = 'https://api.meetup.com/gdgcluj';

  static Future<http.Response> loadEvents({String status = 'upcoming'}) {
    String _endpoint = '/events?status=' + status;

    return http.get(
      Uri.parse(
        _url + _endpoint,
      ),
    );
  }

  static Future<http.Response> loadPhotos({required String event_id}) {
    String _endpoint = '/photos?event_id=' + event_id;

    return http.get(
      Uri.parse(
        _url + _endpoint,
      ),
    );
  }
}
