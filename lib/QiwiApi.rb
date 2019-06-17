require 'base64'
require 'openssl'

require "QiwiApi/version"
require "QiwiApi/payments"
require "QiwiApi/webhook/webhook"
require "QiwiApi/webhook/webhook_response"



module QiwiApi
  class Error < StandardError; end
  # Your code goes here...
end