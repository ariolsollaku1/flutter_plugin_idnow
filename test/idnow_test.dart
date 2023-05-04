import 'package:flutter_test/flutter_test.dart';
import 'package:idnow/idnow.dart';
import 'package:idnow/idnow_platform_interface.dart';
import 'package:idnow/idnow_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockIdnowPlatform
    with MockPlatformInterfaceMixin
    implements IdnowPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final IdnowPlatform initialPlatform = IdnowPlatform.instance;

  test('$MethodChannelIdnow is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelIdnow>());
  });

  test('getPlatformVersion', () async {
    Idnow idnowPlugin = Idnow();
    MockIdnowPlatform fakePlatform = MockIdnowPlatform();
    IdnowPlatform.instance = fakePlatform;

    expect(await idnowPlugin.getPlatformVersion(), '42');
  });
}
