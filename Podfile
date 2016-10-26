source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '8.0'

use_frameworks!

def shared_pods
  pod 'SwiftyJSON', '~> 3.1.1'
  pod 'RealmSwift', '~> 2.0.2'
end

target 'TransitApp' do
  shared_pods
end

target 'TransitAppTests' do
  shared_pods
  pod 'Quick', '~> 0.10.0'
  pod 'Nimble', '~> 5.1.0'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end

