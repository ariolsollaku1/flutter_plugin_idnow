import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'idnow_method_channel.dart';

abstract class IdnowPlatform extends PlatformInterface {
  /// Constructs a IdnowPlatform.
  IdnowPlatform() : super(token: _token);

  static final Object _token = Object();

  static IdnowPlatform _instance = MethodChannelIdnow();

  /// The default instance of [IdnowPlatform] to use.
  ///
  /// Defaults to [MethodChannelIdnow].
  static IdnowPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [IdnowPlatform] when
  /// they register themselves.
  static set instance(IdnowPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<String?> startIdentification(String code) {
    throw UnimplementedError('startIdentification() has not been implemented.');
  }
}
