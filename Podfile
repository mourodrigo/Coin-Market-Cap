source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '11.0'
use_frameworks!

project 'CoinMarketCap.xcodeproj'

def pods
   pod 'SwiftyJSON'
   pod 'Alamofire', '~> 4.7'
   pod 'Alamofire-SwiftyJSON'
   pod 'RealmSwift' 
end

target :CoinMarketCap do
   pods
   target 'CoinMarketCapTests' do
   inherit! :search_paths
end

end

post_install do |installer|
   installer.pods_project.targets.each do |target|
      puts "#{target.name}"
      target.build_configurations.each do |config|
         config.build_settings['SWIFT_VERSION'] = '4.0'
      end
   end
end
