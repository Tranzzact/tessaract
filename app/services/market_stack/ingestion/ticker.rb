module MarketStack
  module Ingestion
    class Ticker
      API_CALL_LIMIT = 5 #PROD_CHNAGE: change this before going live
      API_OBJ_LIMIT = 1000
      def initialize
        @ticker_data = []
        @offset = 0
        @api_counter = 1
        @pagination_total = 0
        # @pagination_total = 180502
      end

      def fetch_and_save_ticker(dry_run: !Rails.env.production?)
        resp = {}
        while (@offset == 0 || (@pagination_total > 0 && @pagination_total > @offset)) && @api_counter <= API_CALL_LIMIT
          if dry_run
            resp =  JSON.parse(File.read("#{Rails.root}/db/tickers.json").to_s)
          else
            resp = MarketStack::ConnectionAdapter.get_tickers(
              opts: {limit: API_OBJ_LIMIT, offset: @offset}
            )
          end

          @api_counter += 1
          break if resp.blank?
          @ticker_data += resp['data']
          @pagination_total = resp.dig('pagination', 'total')
          @offset += API_OBJ_LIMIT
        end
        puts "---TICKER DATA SIZE------: #{@ticker_data.count}"
        MarketStack::Ticker.new.save_ticker_info(@ticker_data)
      end
    end
  end
end