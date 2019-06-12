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

  describe "#payments" do
    context "when arguments set" do
      it "returns array with account, amount & comment" do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77018986329/payments?operation=ALL&rows=1").
        with(
          headers: {
           'Accept'=>'application/json',
           'Authorization'=>'Bearer b1af1687972a12f5bd73ff8108fafb82',
           'Content-Type'=>'application/json'})
        #    }).
        # to_return(status: 200, body: [{:account=>""}, {:amount=>131.5}, {:comment=>"Платеж в Яндекс.Деньги, 25700127759405049"}])
        access = described_class.new(
          'b1af1687972a12f5bd73ff8108fafb82'
          ).payments(1,77018986329,"ALL")
        # expect(response.code).to eq(200)
        expect(access).to include(Hash)
      end
    end
  end

  
end

