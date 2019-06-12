require 'spec_helper'
require './lib/QiwiApi/payments'

RSpec.describe QiwiApi::Client do

  it "is not created without token" do
    expect{QiwiApi::Client.new}.to raise_error ArgumentError
  end

  it "is create with access token" do
    access = QiwiApi::Client.new(access_token: 'b1af1687972a12f5bd73ff8108fafb82')
    expect(access).to be_instance_of(described_class)
  end
end

