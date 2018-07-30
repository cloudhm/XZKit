#
# Be sure to run `pod lib lint XZKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
# pod lib lint --verbose

Pod::Spec.new do |s|
	
	s.name             = 'XZKit'
	s.version          = '3.0.4'
	s.summary          = '一款封装了 iOS App 开发过程中常用的功能和组件的框架!'

	# This description is used to generate tags and improve search results.
	#   * Think: What does it do? Why did you write it? What is the focus?
	#   * Try to keep it short, snappy and to the point.
	#   * Write the description between the DESC delimiters below.
	#   * Finally, don't worry about the indent, CocoaPods strips it!

	s.description = <<-DESC
                    本框架主要包含：常用拓展库、多线程、缓存、数据摘要和加密、视图状态组件、自定义导航控制器及导航条、网络框架规范、控制器重定向、
                    轮播组件和轮播图、进度条、自定义 UICollectionView 布局、App 内容语言切换等功能。
                    DESC

	s.homepage         = 'https://xzkit.mlibai.com'
	# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
	s.license          = { :type => 'MIT', :file => 'LICENSE' }
	s.author           = { 'mlibai' => 'mlibai@163.com' }
	s.source           = { :git => 'https://github.com/mlibai/XZKit.git', :tag => s.version.to_s }
	# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

	# s.module_name  = 'XZKit'
	s.swift_version = "4.2"
	s.ios.deployment_target = '8.0'
	s.requires_arc = true
	s.xcconfig = {
		"GCC_PREPROCESSOR_DEFINITIONS" => '$(inherited) XZKIT_FRAMEWORK=1'
	}

	s.pod_target_xcconfig = { 
		#'OTHER_CFLAGS' => '-fembed-bitcode' 
		# 'DEFINES_MODULE' => 'YES'
	}

	# 使用 .framework 作为 Pods 源。
	s.vendored_frameworks = 'Products/XZKit.framework'

    # 框架文件和公共头文件。
    # XZKit.h 没有这个头文件会导致无法编译，Xcode 编译 framework 时自动生成的 -Swift.h 文件会自动包含该文件。
    # s.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# s.source_files = 'XZKit/XZKit/Code/XZKit.h'
	# 因为分成了多个子模块，指定单一 modulemap 无法适应所有情况，所以需要 Pods 自动生成 modulemap 。
	# s.module_map = 'XZKit/XZKit/module.modulemap'
    # s.frameworks = 'UIKit'
    # s.dependency 'AFNetworking', '~> 2.3'
    # s.default_subspecs = "XZKit"

	# 资源图片。
	# s.resource_bundles = {
	# 	# 须使用 +bundleForClass: 方法构造的 NSBundle 来获取资源。
	# 	# +bundleWithIdentifier: 构造的 NSBundle 无法获取资源 iOS 11，原因未知。
	#  	'XZKit' => ['XZKit/XZKit/Assets.xcassets']
	# }

	# s.subspec 'AlertController' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/AlertController/*.{h,m,swift}'
	# end

	# s.subspec 'AppLanguage' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/AppLanguage/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/AppLanguage/*.{h,m,swift}'
	# 	ss.dependency "XZKit/Category/Bundle"
	# end

	# s.subspec 'AppRedirection' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/AppRedirection/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/AppRedirection/*.{h,m,swift}'

	# 	ss.dependency "XZKit/Constant"
	# 	ss.dependency "XZKit/Category/UIViewController"
	# end

	# s.subspec 'CacheManager' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/CacheManager/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/CacheManager/*.{h,m,swift}'

	# 	ss.dependency 'XZKit/Constant'
	# 	ss.dependency "XZKit/Category/UIColor"
	# 	ss.dependency "XZKit/Category/UIImage"
	# 	ss.dependency "XZKit/DataDigester"
	# end

	# s.subspec 'CarouselView' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/CarouselView/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/CarouselView/*.{h,m,swift}'

	# 	ss.dependency "XZKit/Constant"
	# 	ss.dependency "XZKit/Category/UIImage"
	# end

	# s.subspec 'Castable' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Castable/*.{h,m,swift}'

	# 	ss.dependency "XZKit/Constant"
	# end

	# s.subspec 'Category' do |ss|
	# 	ss.subspec 'Bundle' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/Bundle/*.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/Bundle/*.{h,m,swift}'

	# 		sss.dependency 'XZKit/Constant'
	# 	end
	# 	ss.subspec 'CGGeometry' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/CGGeometry/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'Data' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/Data/*.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/Data/*.{h,m,swift}'

	# 		sss.dependency 'XZKit/Category/String'
	# 	end
	# 	ss.subspec 'Date' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/Date/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'Int' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/Int/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'JSON' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/JSON/*.{h,m,swift}'

	# 		sss.dependency "XZKit/Constant"
	# 		sss.dependency "XZKit/Category/OptionSet"
	# 	end
	# 	ss.subspec 'OptionSet' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/OptionSet/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'String' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/String/*.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/String/*.{h,m,swift}'

	# 		sss.dependency "XZKit/Category/OptionSet"
	# 		sss.dependency "XZKit/Constant"
	# 	end
	# 	ss.subspec 'TimeInterval' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/TimeInterval/*.{h,m,swift}'

	# 		sss.dependency "XZKit/Constant"
	# 	end
	# 	ss.subspec 'UIApplication' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIApplication/*.{h,m,swift}'

	# 		sss.dependency 'XZKit/Category/UIDevice'
	# 	end
	# 	ss.subspec 'UIColor' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIColor/*.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIColor/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'UIDevice' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIDevice/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'UIImage' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIImage/*.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIImage/*.{h,m,swift}'

	# 		sss.dependency "XZKit/Category/Bundle"
	# 	end
	# 	ss.subspec 'UIImageView' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIImageView/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'UIView' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIView/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'UIViewController' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIViewController/*.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIViewController/*.{h,m,swift}'

	# 		sss.dependency "XZKit/Category/UIView"
	# 	end
	# 	ss.subspec 'UIWebView' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/UIWebView/*.{h,m,swift}'
	# 	end
	# 	ss.subspec 'URL' do |sss|
	# 		sss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 		sss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Category/URL/*.{h,m,swift}'

	# 		sss.dependency "XZKit/Category/String"
	# 	end

	# end

	# s.subspec 'CollectionViewFlowLayout' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/CollectionViewFlowLayout/*.{h,m,swift}'
	# end

	# s.subspec 'Constant' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Constant/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Constant/*.{h,m,swift}'

	# 	ss.dependency "XZKit/Category/Date"
	# end

	# s.subspec 'ContentStatusRepresentable' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/ContentStatusRepresentable/*.{h,m,swift}'

	# 	ss.dependency "XZKit/TitledImageView"
	# end

	# s.subspec 'DataCryptor' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/DataCryptor/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/DataCryptor/*.{h,m,swift}'
	# end

	# s.subspec 'DataDigester' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/DataDigester/*.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/DataDigester/*.{h,m,swift}'

	# 	ss.dependency 'XZKit/Category/Data'
	# 	ss.dependency "XZKit/Category/String"
	# end

	# s.subspec 'DispatchQueue' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/DispatchQueue/*.{h,m,swift}'

	# 	ss.dependency "XZKit/Constant"
	# 	ss.dependency "XZKit/Category/OptionSet"
	# end

	# s.subspec 'NavigationController' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/NavigationController/*.{h,m,swift}'

	# 	ss.dependency "XZKit/Constant"
	# 	ss.dependency "XZKit/Category/UIViewController"
	# 	ss.dependency "XZKit/TitledImageView"
	# 	ss.dependency "XZKit/Category/UIImage"
	# end

	# s.subspec 'Networking' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/Networking/*.{h,m,swift}'
		
	# 	ss.dependency "XZKit/Constant"
	# 	ss.dependency "XZKit/DispatchQueue"
	# 	ss.dependency "XZKit/Category/OptionSet"
	# end

	# s.subspec 'ProgressView' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/ProgressView/*.{h,m,swift}'
	# end
	
	# s.subspec 'TitledImageView' do |ss|
	# 	ss.public_header_files = 'XZKit/XZKit/Code/XZKit.h'
	# 	ss.source_files = 'XZKit/XZKit/Code/XZKit.h', 'XZKit/XZKit/Code/TitledImageView/*.{h,m,swift}'
	# end

end
