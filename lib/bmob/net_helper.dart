import 'package:dio/dio.dart';
import 'package:mini_logger/mini_logger.dart';
import 'package:work_hour/bmob/bmob.dart';

import 'table/user.dart';

class BmobNetHelper {
  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      BaseOptions options = BaseOptions(
        baseUrl: "https://api2.bmob.cn",
        contentType: Headers.jsonContentType,
        headers: {
          "X-Bmob-Application-Id": Bmob.appId,
          "X-Bmob-REST-API-Key": Bmob.apiKey,
          "X-Bmob-Master-Key": Bmob.masterKey,
        },
        connectTimeout: 3000,
        receiveTimeout: 10000,
        sendTimeout: 3000,
        responseType: ResponseType.json,
      );
      _dio = Dio(options);
    }
    return _dio!;
  }

  BmobNetHelper._();

  static Future<BmobUser?> login(String username, String pwd) async {
    try {
      var date = await dio.get(
        "/1/login",
        queryParameters: {
          'username': username,
          'password': pwd,
        },
      );
      return BmobUser.fromJson(date.data);
    } on DioError catch (e) {
      L.e(e);
    }
    return null;
  }
}
