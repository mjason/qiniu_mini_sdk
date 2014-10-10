module QiniuMiniSdk
  class Policy
    def initialize args={}
      @params = {}
      args.each do |k, v|
        self.send "#{k}=", v
      end
    end

    def key=(key)
      @key = key
    end

    def bucket=(bucket)
      @bucket = bucket
    end

    def expires_in=(time=3600)
      @params[:deadline] = Time.now.to_i + @params[:expires_in]
    end

    def deadline=(time)
      @params[:deadline] = time if @params[:expires_in].nil?
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
      @params.to_json
    end

  end
end