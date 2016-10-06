require 'rspec'
require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
require 'skio_sms_client'

Dir[File.join(File.dirname(__FILE__), "../spec/support/**/*.rb")].sort.each { |f| require f }
RSpec.configure do |config|
  config.color = true
  config.mock_with :rspec
end

SkioSmsClient.configure do |config|
  config.app_name = "battery_change_service"
  config.send_key = "188e7da3b90047fea7173a74c9b8e021"
  config.send_server = "http://sendsms.skio.cn/send_sms"
end