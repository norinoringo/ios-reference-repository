# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iOSReferenceRepository' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSReferenceRepository
	pod 'SwiftLint'
  pod 'SwiftFormat/CLI', '~> 0.49'

	pod 'R.swift'
	pod 'RxSwift'
	pod 'RxCocoa'
end

# post install
# Xcode14.3からCocoaPodsでインストールしたライブラリのMinimum DevelopmentsがiOS11未満だとビルドエラーになる
# https://developer.apple.com/forums/thread/728021
post_install do |installer|
  # fix xcode 15 DT_TOOLCHAIN_DIR - remove after fix oficially - https://github.com/CocoaPods/CocoaPods/issues/12065
  installer.aggregate_targets.each do |target|
      target.xcconfigs.each do |variant, xcconfig|
      xcconfig_path = target.client_root + target.xcconfig_relative_path(variant)
      IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
      end
  end

  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        if config.base_configuration_reference.is_a? Xcodeproj::Project::Object::PBXFileReference
            xcconfig_path = config.base_configuration_reference.real_path
            IO.write(xcconfig_path, IO.read(xcconfig_path).gsub("DT_TOOLCHAIN_DIR", "TOOLCHAIN_DIR"))
        end
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
   end
  end
end

# Xcode15のビルドエラー不具合が解消されたら以下に戻す
## Xcode14.3からCocoaPodsでインストールしたライブラリのMinimum DevelopmentsがiOS11未満だとビルドエラーになる
## https://developer.apple.com/forums/thread/728021
#post_install do |installer|
#  installer.generated_projects.each do |project|
#    project.targets.each do |target|
#      target.build_configurations.each do |config|
#        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
#      end
#   end
#  end
#end
