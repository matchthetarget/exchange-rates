class CurrenciesController < ApplicationController

  def list_pairs
    # api_url = "https://api.exchangerate.host/symbols"
    api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"
    raw_data = URI.open(api_url).read
    parsed_data = JSON.parse(raw_data)
    # @symbols = parsed_data.fetch("symbols").keys
    @symbols = parsed_data.fetch("currencies").keys

    render("currency_templates/index")
  end

  def first_currency
    @original_currency = params.fetch("from_currency")

    # api_url = "https://api.exchangerate.host/symbols"
    api_url = "http://api.exchangerate.host/list?access_key=#{ENV["EXCHANGE_RATES_KEY"]}"
    raw_data = URI.open(api_url).read
    parsed_data = JSON.parse(raw_data)
    # @symbols = parsed_data.fetch("symbols").keys
    @symbols = parsed_data.fetch("currencies").keys

    render("currency_templates/step_one")
  end

  def convert
    @original_currency = params.fetch("from_currency")
    @destination_currency = params.fetch("to_currency")

    # api_url = "https://api.exchangerate.host/convert?from=#{@original_currency}&to=#{@destination_currency}"
    api_url = "http://api.exchangerate.host/convert?access_key=#{ENV["EXCHANGE_RATES_KEY"]}&from=#{@original_currency}&to=#{@destination_currency}&amount=1"
    raw_data = URI.open(api_url).read
    parsed_data = JSON.parse(raw_data)
    
    # @exchange_rate = parsed_data.fetch("info").fetch("rate")
    @exchange_rate = parsed_data.fetch("result")
    
    render("currency_templates/step_two")
  end
end
