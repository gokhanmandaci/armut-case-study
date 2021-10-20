platform :ios, '12.0'
use_frameworks!

def defaultPods
  pod 'Moya', '~> 15.0'
  pod 'Kingfisher', '~> 7.0'
  pod 'SVProgressHUD'
  pod 'SwiftSVG', '~> 2.0'
  pod 'CocoaDebug', :configurations => ['Debug']
end

target 'Armut CaseStudy' do
  defaultPods

  target 'Armut CaseStudyTests' do
    inherit! :search_paths
    defaultPods
  end

  target 'Armut CaseStudyUITests' do
    defaultPods
  end

end
