
import 'package:get_storage/get_storage.dart';

StorageFactory? get _getBox => () => GetStorage('work_pref');

class PrefUtil {
  static Future<bool> init() => GetStorage.init("work_pref");

  final _login = false.val("login", getBox: _getBox, defVal: false);
  final _username = ''.val('username', getBox: _getBox, defVal: '');
  // final _user = ''.val("user", getBox: _getBox, defVal: '');

  bool get login => _login.val;

  set login(bool login) => _login.val = login;

  String get username => _username.val;

  set username(String username) => _username.val = username;

  // BmobUser? get user {
  //   if (_user.val.isEmpty) {
  //     return null;
  //   }
  //   return BmobUser.fromJson(jsonDecode(_user.val));
  // }

  // set user(BmobUser? user) {
  //   if (user == null) {
  //     _user.val = '';
  //   } else {
  //     _user.val = jsonEncode(user.toJson());
  //   }
  // }
}

final PrefUtil prefUtil = PrefUtil();
