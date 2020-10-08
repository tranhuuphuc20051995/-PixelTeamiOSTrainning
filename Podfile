# Uncomment the next line to define a global platform for your project
platform :ios, '12.0'
inhibit_all_warnings!

def pods
  # Clean Architecture
  pod 'RxSwift', '5.1.1'
  pod 'RxCocoa', '5.1.1'
  pod 'RxAlamofire', '5.6.0'
    
  # Others
  pod 'SDWebImage', '5.8.4'
  pod 'Localize-Swift', '3.1.0'
  
  # SVProgressHUD
  pod 'SVProgressHUD' , '2.2.5'
end


target 'Trainning' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  pods
  # Pods for Trainning

  target 'TrainningTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'TrainningUITests' do
    # Pods for testing
  end

end
