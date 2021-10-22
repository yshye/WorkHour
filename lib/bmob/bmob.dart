class Bmob {
  static late String appId;
  static late String apiKey;
  static late String masterKey;
  static String? token;

  static void initMasterKey(String appId, String apiKey, String masterKey) {
    Bmob.apiKey = apiKey;
    Bmob.appId = appId;
    Bmob.masterKey = masterKey;
  }


}
