Pod::Spec.new do |s|
  s.name             = 'PopupUpdate'
  s.version          = '1.0.2'
  s.summary          = 'PopupUpdate is a library which provide us an easy way to show a popup for new available version for the current application.'
  s.description      = <<-DESC
"PopupUpdate is a library which provide us an easy way to show a popup for new available version for the current application."
                       DESC

  s.homepage         = 'https://github.com/scalefocus/PopupUpdate'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Scalefocus' => 'ios@scalefocus.com' }
  s.source           = { :git => 'https://github.com/scalefocus/PopupUpdate.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_versions = '4.0'

  s.source_files = 'PopupUpdate/Classes/**/*'
end
