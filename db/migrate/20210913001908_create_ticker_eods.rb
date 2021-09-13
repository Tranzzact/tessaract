class CreateTickerEods < ActiveRecord::Migration[6.1]
  def change
    create_table :ticker_eods do |t|
      t.decimal :open, precision: 15, scale: 4, null: false
      t.decimal :high, precision: 15, scale: 4, null: false
      t.decimal :low, precision: 15, scale: 4, null: false
      t.decimal :close, precision: 15, scale: 4, null: false
      t.decimal :volume, precision: 15, scale: 4, null: false
      t.decimal :adj_high, precision: 15, scale: 4
      t.decimal :adj_low, precision: 15, scale: 4
      t.decimal :adj_close, precision: 15, scale: 4, null: false
      t.decimal :adj_open, precision: 15, scale: 4
      t.decimal :adj_volume, precision: 15, scale: 4
      t.decimal :split_factor, precision: 15, scale: 4, null: false
      t.string :symbol, null: false
      t.references :ticker
      t.references :stock_exchange
      t.datetime :date
      t.timestamps
    end
  end
end
