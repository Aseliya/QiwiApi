require "httparty"

module QiwiApi
	class Client

		def initialize(access_token)
			@access_token = access_token
		end

		def payments(qty, number, operation)
			url = "https://edge.qiwi.com/payment-history/v2/persons/#{number}/payments?rows=#{qty}&operation=#{operation}"
			response = HTTParty.get(url, headers: { 'Authorization' => "Bearer #{@access_token}" , 'Accept' => " application/json", 'Content-Type' => 'application/json'})
			response.parsed_response
		end
		
	end
end
