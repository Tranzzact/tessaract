module MarketStack
  class Ticker
    def initialize
      @service_api = 'marketsack'
      @stock_exchanges = ::StockExchange.all.index_by(&:mic)
    end

    def save_ticker_info(data = [])
      data.each do |obj|
        se = @stock_exchanges[obj['stock_exchange']['mic']]
        unless se
          puts "-----#{self.class.name}--------" + "#{obj}"
          next
        end

        ticker = ::Ticker.where(symbol: obj['symbol']).first_or_initialize
        ticker.stock_exchange = se
        ticker.service_api = @service_api
        ticker.assign_attributes(
          obj.except('stock_exchange')
        )

        unless ticker.save
          puts "-----#{self.class.name}--------" + ticker.errors.full_message.join(",")
          next
        end
      end
    end
  end
end