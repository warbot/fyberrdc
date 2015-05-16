class CreateFyberOffers < ActiveRecord::Migration
  def change
    create_table :fyber_offers do |t|

      t.timestamps null: false
    end
  end
end
