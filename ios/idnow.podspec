#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint idnow.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'idnow'
  s.version          = '0.0.1'
  s.summary          = 'A new Flutter plugin project.'
  s.description      = <<-DESC
A new Flutter plugin project.
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
	s.vendored_frameworks = 'Frameworks/XS2AiOSNetService.xcframework', 'Frameworks/FaceTecSDK.xcframework', 'Frameworks/IDNowSDKCore.xcframework'
	s.preserve_paths = 'Frameworks/**/**/*'
	s.xcconfig = { 'OTHER_LDFLAGS' => ' -framework FaceTecSDK -framework XS2AiOSNetService -framework IDNowSDKCore' }
	s.platform = :ios, '11.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386','ENABLE_BITCODE' => 'NO' }
  s.swift_version = '5.0'
end
