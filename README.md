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
end

qiniu = QiniuMiniSdk::Policy.new bucket: '你的buckname'
qiniu.uptoken
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/qiniu_mini_sdk/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
