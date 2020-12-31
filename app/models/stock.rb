class Stock < ApplicationRecord

  def self.new_lookup(ticker_symbol)
    client = IEX::Api::Client.new(
      publishable_token: Rails.application.credentials.iex[:publishable_token],
      secret_token: Rails.application.credentials.iex[:secret_token],
      endpoint: 'https://sandbox.iexapis.com/v1'
    )
    begin
      new(ticker_symbol: ticker_symbol, name: client.company(ticker_symbol).company_name, price: client.price(ticker_symbol))      
    rescue => exception
      nil      
    end
  end
end
