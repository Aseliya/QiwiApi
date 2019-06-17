module QiwiApi

  class Webhook
    def initialize(key)
      @key = key #получение ключа "key":"zpgzvWqhRJ+px4l7BTXqgk09Y486CjkPP8ZRK1zTbtM=" (каждый вебхук содержит цифровую подпись сообщения, зашифрованную ключом)
    end

    def payments(params)
      return WebhookResponse.new(body: params) if params.dig(:test) == true

      if sign_correct?(params)
        return WebhookResponse.new(body: params)
      else
        return WebhookResponse.new(body: params.dig(:payment, :txnId))
      end
    end

    private

    def sign_correct?(params)
      sign_fields = "#{params.dig(:payment, :sum, :currency)}|#{params.dig(:payment, :sum, :amount)}|#{params.dig(:payment, :type)}|#{params.dig(:payment, :account)}|#{params.dig(:payment, :txnId)}"
      secret_key = Base64.decode64(@key)
      secure_hash = OpenSSL::HMAC.hexdigest('SHA256', secret_key, sign_fields)
      params[:hash] == secure_hash
    end
  end
end