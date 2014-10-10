# QiniuMiniSdk

一个无依赖的七牛sdk, 只是生成上传凭证

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'qiniu_mini_sdk'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install qiniu_mini_sdk

## Usage

```ruby
QiniuMiniSdk.setup do |config|
  config.access_key = 'xxxx'
  config.secret_key = 'sdfadsf'
  # 如果你的bucket, 和你的默认url不同(比如你使用的是https的url), 可以使用下面的方法
  config.bucket_url 'test-123123', 'https://dn-test12312313.qbox.me'
  config.bucket_url 'test-12312', "https://dn-werwer.qbox.me"
end

qiniu = QiniuMiniSdk::Policy.new bucket: '你的buckname'
qiniu.uptoken

# 获取下载地址
qiniu = QiniuMiniSdk::Policy.new bucket: '你的buckname', key: '你下载资源的key', expires_in: '有效期,可以不填直接忽略这个参数, 默认为3600秒'
qiniu.download_url
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/qiniu_mini_sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
