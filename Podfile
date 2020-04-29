# Uncomment the next line to define a global platform for your project
 platform :ios, '11.0'

def default_pods
  pod 'ObjectMapper'
  pod 'CryptoSwift'
  pod 'AlamofireObjectMapper'
  pod 'Alamofire', '~> 4.5'
  pod 'Kingfisher', '~> 4.0'
end

def tests_pod
  pod 'Quick'
  pod 'Nimble'
end

target 'MarvelApp' do

  #use_frameworks!

  default_pods
  pod 'UITestHelper/App'

  # Pods for MarvelApp

  target 'MarvelAppTests' do
    inherit! :search_paths
    tests_pod
    # Pods for testing
  end

  target 'MarvelAppUITests' do
    # Pods for testing
    default_pods
    tests_pod
    pod 'UITestHelper'
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      if ['UITestHelperUITests'].include? target.name
        target.build_configurations.each do |config|
          config.build_settings['ENABLE_BITCODE'] = 'NO'
        end
      end
    end
  end

end
