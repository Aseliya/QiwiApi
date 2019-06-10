require "QiwiApi/version"
require "httparty"

	class Client

		def initialize(access_token=nil)
			@access_token = access_token
		end

		def payments(qty, number, operation)
			url = "https://edge.qiwi.com/payment-history/v2/persons/#{number}/payments?rows=#{qty}&operation=#{operation}"
			response = HTTParty.get(url, headers: { 'Authorization' => "Bearer #{@access_token}" , 'Accept' => " application/json", 'Content-Type' => 'application/json'})
    end
	end
  # client = Client.new("b1af1687972a12f5bd73ff8108fafb82")
  # payments_history = client.payments(5, 77018986329, "IN")
  # p payments_history
