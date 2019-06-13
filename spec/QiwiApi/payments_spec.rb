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
      it "returns hash with account, amount & comment" do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77018986329/payments?operation=ALL&rows=1").
        with(
          headers: {
           'Accept'=>'application/json',
           'Authorization'=>'Bearer b1af1687972a12f5bd73ff8108fafb82',
           'Content-Type'=>'application/json'
           }).
        to_return(status: 200, body: {:account=>"", :amount=>131.5, :comment=>"Платеж в Яндекс.Деньги, 25700127759405049"}.to_json)
        access = QiwiApi::Client.new(
          'b1af1687972a12f5bd73ff8108fafb82'
          ).payments('1', '77018986329','ALL')
        expect(access).to eq({"account" => "", "amount" => 131.5, "comment" => 'Платеж в Яндекс.Деньги, 25700127759405049'}.to_json)

      end
    end

    context "when access token is not correct" do
      it "returns with 'Error 401 Unauthorized' message " do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77018986329/payments?operation=ALL&rows=1").
        with(
          headers: {
           'Accept'=>'application/json',
           'Authorization'=>'Bearer b1af1687972a12f5bd73ff8108fafb99',
           'Content-Type'=>'application/json'
           }).
        to_return(status: [401, 'Unauthorized'])
        access = QiwiApi::Client.new(
          'b1af1687972a12f5bd73ff8108fafb99'
          ).payments('1', '77018986329','ALL')
        expect(access).to eq(nil)
      end
    end

    context "when wallet is not correct" do
      it "returns with 'Error 403 Forbidden' message " do
        stub_request(:get, "https://edge.qiwi.com/payment-history/v2/persons/77018986322/payments?operation=ALL&rows=1").
        with(
          headers: {
           'Accept'=>'application/json',
           'Authorization'=>'Bearer b1af1687972a12f5bd73ff8108fafb82',
           'Content-Type'=>'application/json'
           }).
        to_return(status: [403, 'Forbidden'])
        access = QiwiApi::Client.new(
          'b1af1687972a12f5bd73ff8108fafb82'
          ).payments('1','77018986322','ALL')
        expect(access).to eq(nil)
      end
    end
  end
end

