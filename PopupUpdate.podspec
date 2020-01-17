Pod::Spec.new do |s|
  s.name             = 'PopupUpdate'
  s.version          = '1.0.0'
  s.summary          = 'PopupUpdate is a library which provide us an easy way to show a popup for new available version for the current application.'
  s.description      = <<-DESC
"PopupUpdate is a library which provide us an easy way to show a popup for new available version for the current application."
                       DESC

  s.homepage         = 'https://bitbucket.upnetix.com/projects/IL/repos/popup-update'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Upnetix' => 'code@upnetix.com' }
  s.source           = { :git => 'https://bitbucket.upnetix.com/scm/il/popup-update.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_versions = '4.0'

  s.source_files = 'PopupUpdate/Classes/**/*'
end
