require "qiniu_mini_sdk/version"

module QiniuMiniSdk
  # Your code goes here...
  autoload :Policy, 'qiniu_mini_sdk/policy'

  def self.setup
    yield self
  end

  class << self
    attr_accessor :access_key, :secret_key
  end

end
