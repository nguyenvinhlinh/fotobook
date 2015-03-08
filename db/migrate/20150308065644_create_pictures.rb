class CreatePictures < ActiveRecord::Migration
  def change
    create_table :pictures do |t|
      t.string :tags
      t.string :url

      t.timestamps null: false
    end
  end
end
