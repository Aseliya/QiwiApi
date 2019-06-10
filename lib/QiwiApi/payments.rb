
require "httparty"

module QiwiApi
	class Client
			def initialize(access_token = nil)
					@access_token = access_token
			end

			def payments(qty, number, operation)
					url = "https://edge.qiwi.com/payment-history/v2/persons/#{number}/payments?rows=#{qty}&operation=#{operation}"
					response = HTTParty.get(url, headers: { 'Authorization' => "Bearer #{@access_token}" , 'Accept' => " application/json", 'Content-Type' => 'application/json'})
					sum = response.to_a
					amount = sum[0][1][0]["total"]["amount"]
					date = sum[0][1][0]["date"]
					comment = sum[0][1][0]["comment"]
					p amount, date, comment
				end
	end
end