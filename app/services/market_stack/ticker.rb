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

    def save_ticker_eod_info(symbol:, data: [])
      # {'XANS' => <StockExchange>, 'NYSE' => <>}
      stock_exchanges = ::StockExchange.all.index_by(&:mic)
      ticker = ::Ticker.find_by_symbol(symbol)
      data.each do |obj|
        ticker_eod = TickerEod.find_by_date(obj['date'])
        next if ticker_eod

        obj.merge!({
          ticker: ticker,
          stock_exchange: stock_exchanges[obj['exchange']]
        })

        ticker_eod = TickerEod.new(obj.except('exchange', 'ticker'))
        unless ticker_eod.save
          puts "-----#{self.class.name}--------" + ticker_eod.errors.full_message.join(",")
          next
        end

      end
    end
  end
end