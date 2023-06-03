import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static void init() {
    dio = Dio(
      BaseOptions(baseUrl: 'https://fcm.googleapis.com/', headers: {
        'Content-Type': 'application/json',
        'Authorization':
            'key=BMEunL7KBIXniY0dYufZzjfrumb7woTYud97YO4zYkVEqws_OVxgTiqpMvTMagLcqbHxgY5S5tFgrXxYH8xM5cI',
      }),
    );
  }

 static Future<Response> send(String deviceToken, String title, String body) async{
  return await  dio!.post('fcm/send', data: {
      "to": "${deviceToken}",
      "notification": {
        "title": "${title}",
        "body": "${body}",
        // "mutable_content": true,
        //"sound": "Tri-tone"
        "sound": "default"
      },
      "android": {
        "priorty": "HIGH",
        "notification": {
          "sound": "default",
          "default_sound": "true",
          "default_vibrate_timings": "true",
          "default_light_settings": "true"
        }
      },
      "data": {
        "type": "order",
        "id": "87",
        "click_action": "FLUTTER_NOTIFICATION_CLICK"
      }
    });
  }
}
