class CreateRatesHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :rates_histories do |t|
      t.date :date, default: Date.today

      t.string :from_currency
      t.string :to_currency
      t.decimal :rate, precision: 12, scale: 6

      t.timestamps
    end

    add_index :rates_histories, [:date, :from_currency, :to_currency], unique: true
  end
end
