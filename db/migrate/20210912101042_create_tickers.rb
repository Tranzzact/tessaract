class CreateTickers < ActiveRecord::Migration[6.1]
  def change
    create_table :tickers do |t|
      t.string :name
      t.string :symbol
      t.string :has_intraday
      t.string :has_eod
      t.string :country
      t.references :stock_exchange
      t.string :service_api
      t.timestamps
    end
  end
end
