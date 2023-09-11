# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Rawg Io API' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Rawg Io API
  pod 'SDWebImage', '~> 5.0'
  pod 'MaterialComponents/Snackbar'
  pod 'Alamofire'
  pod 'RealmSwift', '~>10'

  post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
               end
          end
      end
  end

end
