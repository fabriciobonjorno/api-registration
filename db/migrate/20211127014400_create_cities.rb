class CreateCities < ActiveRecord::Migration[6.1]
  def change
    create_table :cities do |t|
      t.string :name, limit: 255, comment: 'City name'
      t.references :state, null: false, foreign_key: true, comment: 'Relationship State'

      t.timestamps
    end
  end
end
