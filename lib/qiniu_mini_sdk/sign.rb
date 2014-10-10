module QiniuMiniSdk
  module Sign
    module_function
    def urlsafe_base64_encode content
      Base64.encode64(content).strip.gsub('+', '-').gsub('/','_').gsub(/\r?\n/, '')
    end

    def hmac_sha1_sign(data)
      digest = OpenSSL::Digest.new('sha1')
      urlsafe_base64_encode OpenSSL::HMAC.digest(digest, QiniuMiniSdk.secret_key, data)
    end
  end
end