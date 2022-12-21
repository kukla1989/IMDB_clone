class CreateRates < ActiveRecord::Migration[7.0]
  def change
    create_table :rates do |t|
      t.integer :rating
      t.integer :user_id
      t.integer :movie_id

      t.timestamps
    end
  end
end
