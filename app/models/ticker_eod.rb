class TickerEod < ApplicationRecord
	belongs_to :ticker
	belongs_to :stock_exchange
end
