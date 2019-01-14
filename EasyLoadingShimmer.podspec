Pod::Spec.new do |s|
s.name         = "EasyLoadingShimmer"
s.version      = "1.0.0"
s.summary      = "这是一个网络请求页面加载等待的的框架，目前饿了么、京东、简书等都是用此动态效果，接入方便快捷。"
s.homepage     = "https://github.com/wsj2012/EasyLoadingShimmer"
s.license      = "MIT"
s.author       = { "wsj_2012" => "time_now@yeah.net" }
s.source       = { :git => "https://github.com/wsj2012/EasyLoadingShimmer.git", :tag => "#{s.version}" }
s.requires_arc = true
s.ios.deployment_target = "9.0"
s.source_files  = "Libs/*.{swift}"
s.swift_version = '4.2'

end
