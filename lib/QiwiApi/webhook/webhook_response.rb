module QiwiApi
  class WebhookResponse

    def initialize(body)
      @body = parse_body(body)
    end

    private

    def parse_body(body)
      parsed_body = body[:payment]
      return parsed_body.select { |key, val| key != :signFields }.to_h
    end
  end
end