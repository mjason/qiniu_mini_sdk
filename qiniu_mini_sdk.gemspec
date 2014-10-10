# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'qiniu_mini_sdk/version'

Gem::Specification.new do |spec|
  spec.name          = "qiniu_mini_sdk"
  spec.version       = QiniuMiniSdk::VERSION
  spec.authors       = ["mjason"]
  spec.email         = ["tywf91@gmail.com"]
  spec.summary       = %q{一个非常小的七牛, 只提供上传策略}
  spec.description   = %q{提供生成上传策略的sdk, 去除上传文件过程}
  spec.homepage      = "https://github.com/mjason/qiniu_mini_sdk"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
