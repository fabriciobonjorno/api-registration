class CreateStates < ActiveRecord::Migration[6.1]
  def change
    create_table :states do |t|
      t.string :name, limit: 255, comment: 'State name'
      t.string :initials, limit: 2, comment: 'State Initial'

      t.timestamps
    end
  end
end
