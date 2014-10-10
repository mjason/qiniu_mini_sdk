require "qiniu_mini_sdk/version"

module QiniuMiniSdk
  # Your code goes here...
  autoload :Policy, 'qiniu_mini_sdk/policy'
  autoload :Sign, 'qiniu_mini_sdk/sign'

  def self.setup
    QiniuMiniSdk.default
    yield self
  end

  class << self
    attr_accessor :access_key, :secret_key, :urls

    def bucket_url bucket_name, bucket_url
      @urls[bucket_name] = bucket_url
    end

    def default
      @urls ||= {}
    end
  end

end
