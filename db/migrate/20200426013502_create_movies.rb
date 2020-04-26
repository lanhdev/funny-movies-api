class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.references :user, foreign_key: true
      t.string :url, null: false, default: ''

      t.timestamps
    end
  end
end
