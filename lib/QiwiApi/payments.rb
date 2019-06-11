require "httparty"

module QiwiApi
	class Client
		def initialize(access_token)
			@access_token = access_token
		end

		def payments(qty, number, operation)
			payments_history = []
			url = "https://edge.qiwi.com/payment-history/v2/persons/#{number}/payments?rows=#{qty}&operation=#{operation}"
			response = HTTParty.get(url, headers: { 'Authorization' => "Bearer #{@access_token}" , 'Accept' => " application/json", 'Content-Type' => 'application/json'})
			response["data"].each do |item|
				hash = {
					account: item["account"],
					amount: item["total"]["amount"],
					comment: item["comment"]
				}
				payments_history << hash
			end
			payments_history
		end
	end
end