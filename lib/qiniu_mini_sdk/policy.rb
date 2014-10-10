module QiniuMiniSdk
  class Policy
    def initialize bucket, expires_in=3600, deadline=0, key=0
      @params = {}
      @bucket = bucket
      @key = key
      @expires_in = expires_in
      @deadline = deadline
    end

    def deadline
      return deadline if deadline > 0
      Time.now.to_i + @expires_in
    end

    def scope
      if @key.nil?
        @bucket
      else
        "#{@bucket}:#{@key}"
      end
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
        params[$1] = args
      end
    end

    private
    def to_json

    end

  end
end