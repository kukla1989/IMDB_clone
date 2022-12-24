class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.integer :movie_id, index: true
      t.integer :user_id, index: true
      t.integer :rating, null: false

      t.timestamps
    end
    add_index :rates, [:user_id, :movie_id], unique: true
  end
end
