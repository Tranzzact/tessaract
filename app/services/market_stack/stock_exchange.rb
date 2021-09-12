module MarketStack
  class StockExchange
    def initialize
      @service_api = 'marketsack'
    end

    def fetch_market_stack_exchange_info
      # returns db/seed/stock_exchanges.json
    end

    def save_exchange_info(data = [])
      data.each do |obj|
        merge_timezone_info obj
        merge_currency_info obj

        se = ::StockExchange.where(mic: obj['mic']).first_or_initialize
        se.service_api = @service_api
        obj.delete('mic')
        se.assign_attributes obj
        unless se.save
          puts "-----#{self.class.name}--------" + se.errors.full_message.join(",")
          next
        end
      end
    end

    def merge_timezone_info(obj)
      if obj['timezone'].blank?
        obj.delete('timezone')
        return
      end

      obj.merge!({
        timezone: obj['timezone']['timezone'],
        timezone_abbr: obj['timezone']['timezone_abbr']
      })
      obj.delete('timezone')
    end

    def merge_currency_info(obj)
      if obj['currency'].blank?
        obj.delete('currency')
        return 
      end

      obj.merge!({
        currency_code: obj['currency']['currency_code'],
        currency_symbol: obj['currency']['currency_symbol'],
        currency_name: obj['currency']['currency_name']
      })
      obj.delete('currency')
    end
  end
end