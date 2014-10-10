# coding: utf-8
require 'hmac-sha1'
require 'uri'
require 'cgi'

module QiniuMiniSdk
  class Policy
    def initialize args={}
      @params = {}
      args.each do |k, v|
        self.send "#{k}=", v
      end
      default
    end

    def key=(key)
      @key = key
    end

    def bucket=(bucket)
      @bucket = bucket
    end

    def expires_in=(time)
      @params[:deadline] = Time.now.to_i + @params[:expires_in]
    end

    def uptoken
      access_key = Config.settings[:access_key]
      secret_key = Config.settings[:secret_key]

      encoded_put_policy = Utils.urlsafe_base64_encode(self.to_json)
      sign = HMAC::SHA1.new(secret_key).update(encoded_put_policy).digest
      encoded_sign = Utils.urlsafe_base64_encode(sign)

      "#{access_key}:#{encoded_sign}:#{encoded_put_policy}"
    end

    def method_missing(meth, *args, &blk)
      if meth =~ /(.+)=/
        @params[$1.to_s] = args.first
      end
    end

    def to_json
      @params.map {|k, v|
        [change_key(k), v]
      }.to_h.to_json
    end

    private
    def change_key(key)
      key.each_with_index.map { |value, index|
        if i != 0
          value.capitalize
        else
          value
        end
      }.join
    end

    def default
      raise "没有指定bucket" if @bucket.nil?
      self.expires_in = 3600 if @params[:deadline].nil?
      @params[:scope] = "#{@bucket}:#{@key}" unless @key.nil?
      @params[:scope] = "#{@bucket}" if @key.nil?
    end

  end
end