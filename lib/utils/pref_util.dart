import 'dart:convert';

import 'package:get_storage/get_storage.dart';
import 'package:work_hour/bmob/tables/user.dart';

StorageFactory? get _getBox => () => GetStorage('work_pref');

class PrefUtil {
  static Future<bool> init() => GetStorage.init("work_pref");

  final _login = false.val("login", getBox: _getBox, defVal: false);

  // final _username = ''.val('username', getBox: _getBox, defVal: '');
  final _user = ''.val("user", getBox: _getBox, defVal: '');

  bool get login => _login.val;

  set login(bool login) => _login.val = login;

  UserTable get user => UserTable()..fromJson(jsonDecode(_user.val));

  set user(UserTable user) => _user.val = jsonEncode(user.toJson());
}

final PrefUtil prefUtil = PrefUtil();
