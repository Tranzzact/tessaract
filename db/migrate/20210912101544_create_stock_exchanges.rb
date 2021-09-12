class CreateStockExchanges < ActiveRecord::Migration[6.1]
  def change
    create_table :stock_exchanges do |t|
      t.string :name
      t.string :acronym
      t.string :mic
      t.string :country
      t.string :country_code
      t.string :city
      t.string :website
      t.string :timezone
      t.string :timezone_abbr
      t.string :currency_code
      t.string :currency_symbol
      t.string :currency_name
      t.string :service_api

      t.timestamps
    end
  end
end
