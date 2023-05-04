import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'idnow_platform_interface.dart';

/// An implementation of [IdnowPlatform] that uses method channels.
class MethodChannelIdnow extends IdnowPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('idnow');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<String?> startIdentification(String code) async {
    final version = await methodChannel.invokeMethod<String>('startIdentification', {"code": code});
    return version;
  }
}
