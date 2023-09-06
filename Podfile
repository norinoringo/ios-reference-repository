# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'iOSReferenceRepository' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for iOSReferenceRepository

	pod 'SwiftLint'
	pod 'R.swift'

	pod 'RxSwift'
	pod 'RxCocoa'

	pod 'Alamofire'
	pod 'AlamofireImage'

	pod 'SwiftyUserDefaults', '~> 5.0'
  pod "PromiseKit", "~> 6.8"

end

# Xcode14.3からCocoaPodsでインストールしたライブラリのMinimum DevelopmentsがiOS11未満だとビルドエラーになる
# https://developer.apple.com/forums/thread/728021
post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      end
   end
  end
end
