class CreateCurrencyRates < ActiveRecord::Migration[5.1]
  def change
    create_table :currency_rates do |t|
      t.decimal :value, precision: 8, scale: 5
      t.datetime :forced_until, index: true

      t.timestamps
    end
  end
end
