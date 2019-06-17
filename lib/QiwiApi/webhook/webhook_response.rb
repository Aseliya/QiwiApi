module QiwiApi
  class WebhookResponse
    # attr_reader :error, :value
    def initialize(body)
      # @success = success
      # if @success
        @body = parse_body(body)
      # else
      #   @error = error_description(body)
      # end
    end

    # def success?
    #   @success
    # end

    # private

    def parse_body(body)
      # if body[:test] != true
        parsed_body = body[:payment]
        return parsed_body.select { |key, val| key != :signFields }.to_h
      else
        return body
      end
    end

    # def error_description(body)
    #   "This ##{body} transaction is not authenticated"
    # end
  end
end