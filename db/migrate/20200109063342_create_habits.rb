class CreateHabits < ActiveRecord::Migration[5.2]
  def change
    create_table :habits do |t|
      t.string :title
      t.string :description
      t.string :cue
      t.string :craving
      t.string :response
      t.string :reward
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
