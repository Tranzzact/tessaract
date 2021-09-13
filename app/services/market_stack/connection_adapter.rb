module MarketStack
  class ConnectionAdapter
    BASE_API_URL = Settings.marketstack.api
    def self.get_tickers(opts: {})
      if opts[:access_key].blank?
        opts.merge!(access_key: Settings.marketstack.keys.values.sample)
      end
      puts "Attempting to get ticker data: #{opts}"

      resp = Faraday.get("#{BASE_API_URL}tickers", opts)
      resp_body = JSON.parse(resp.body)
      if resp.status == 200
        return resp_body
      else
        puts "-------#{self.class.name}-------" + resp
        {}
      end
    end

    def self.get_ticker_eod(symbol:, opts: {})
      if opts[:access_key].blank?
        opts.merge!(access_key: Settings.marketstack.keys.values.sample)
      end
      puts "Attempting to get ticker data: #{opts}"
      opts.merge!(symbols: symbol)

      resp = Faraday.get("#{BASE_API_URL}eod", opts)
      resp_body = JSON.parse(resp.body)
      if resp.status == 200
        return resp_body
      else
        puts "-------#{self.class.name}-------" + resp
        {}
      end
    end
  end
end