
import 'idnow_platform_interface.dart';

class Idnow {
  Future<String?> getPlatformVersion() {
    return IdnowPlatform.instance.getPlatformVersion();
  }
  Future<String?> startIdentification(String code) {
    return IdnowPlatform.instance.startIdentification(code);
  }
}
