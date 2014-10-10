require "qiniu_mini_sdk/version"

module QiniuMiniSdk
  # Your code goes here...
  autoload :Policy, 'qiniu_mini_sdk/policy'

  class << self
    attr_accessor :access_key, :secret_key

    def setup
      yield self
    end
  end

end
