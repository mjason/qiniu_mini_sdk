# coding: utf-8

require 'json'
require 'base64'
require 'openssl'

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
      @params[:deadline] = Time.now.to_i + time
    end

    def uptoken
      access_key = QiniuMiniSdk.access_key
      encoded_put_policy = urlsafe_base64_encode(self.to_json)
      "#{access_key}:#{encoded_sign}:#{hmac_sha1_sign encoded_put_policy}"
    end

    def download_url
      base_url = QiniuMiniSdk.urls[@bucket] || "http://#{@bucket}.qiniudn.com"
      url = "#{base_url}/#{@key}?e=#{@params[:deadline]}"
      "#{url}&token=#{QiniuMiniSdk.access_key}:#{hmac_sha1_sign url}"
    end

    def method_missing(meth, *args, &blk)
      if meth =~ /(.+)=/
        @params[$1.to_s] = args.first
      end
    end

    def to_json
      JSON.generate @params.map {|k, v|
        [change_key(k.to_s), v]
      }.to_h
    end

    private
    def change_key(key)
      key.split("_").each_with_index.map { |value, index|
        if index == 0
          value
        else
          value.capitalize
        end
      }.join
    end

    def default
      raise "没有指定bucket" if @bucket.nil?
      self.expires_in = 3600 if @params[:deadline].nil?
      @params[:scope] = "#{@bucket}:#{@key}" unless @key.nil?
      @params[:scope] = "#{@bucket}" if @key.nil?
    end

    def urlsafe_base64_encode content
      Base64.encode64(content).strip.gsub('+', '-').gsub('/','_').gsub(/\r?\n/, '')
    end

    def hmac_sha1_sign(data)
      digest = OpenSSL::Digest.new('sha1')
      urlsafe_base64_encode OpenSSL::HMAC.digest(digest, QiniuMiniSdk.secret_key, data)
    end

  end
end