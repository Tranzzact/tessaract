module MarketStack
  module Ingestion 
    class TickerEod
      API_CALL_LIMIT = 2 #PROD_CHNAGE: change this before going live
      API_OBJ_LIMIT = 1000
      def initialize
        @ticker_eod_data = []
        @offset = 0
        @api_counter = 1
        @pagination_total = 0
      end

      def fetch_and_save_ticker_eod(symbol:, dry_run: !Rails.env.production?, opts: {})
        resp = {}
        while (@offset == 0 || (@pagination_total > 0 && @pagination_total > @offset)) && @api_counter <= API_CALL_LIMIT
          if dry_run
            resp =  JSON.parse(File.read("#{Rails.root}/db/apple_01_01-09_12_eod.json").to_s)
          else
            resp = MarketStack::ConnectionAdapter.get_ticker_eod(
              symbol: symbol,
              opts: {limit: API_OBJ_LIMIT, offset: @offset}.merge!(opts)
            )
          end
          @api_counter += 1
          break if resp.blank?
          @ticker_eod_data += resp['data']
          @pagination_total = resp.dig('pagination', 'total')
          @offset += API_OBJ_LIMIT
        end
        puts "---TICKER EOD DATA SIZE------: #{@ticker_eod_data.count}"
        MarketStack::Ticker.new.save_ticker_eod_info(symbol: symbol, data: @ticker_eod_data)
      end
    end
  end
end