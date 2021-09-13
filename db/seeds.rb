# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Ticker.delete_all
StockExchange.delete_all
TickerEod.delete_all


stock_exchanges = JSON.parse(File.read("#{Rails.root}/db/stock_exchanges.json").to_s)
MarketStack::StockExchange.new.save_exchange_info(stock_exchanges['data'])

ticker_data =  JSON.parse(File.read("#{Rails.root}/db/tickers.json").to_s)
MarketStack::Ticker.new.save_ticker_info(ticker_data['data'])

ticker_eod_data =  JSON.parse(File.read("#{Rails.root}/db/apple_01_01-09_12_eod.json").to_s)
MarketStack::Ticker.new.save_ticker_eod_info(symbol: 'AAPL', data: ticker_eod_data['data'])