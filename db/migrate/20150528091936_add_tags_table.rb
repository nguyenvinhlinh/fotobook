class AddTagsTable < ActiveRecord::Migration
  def change
    #remove column tags in pictures table
    remove_column(:pictures,:tags )

    #create new table named tags
    create_table :tags  do |t|
      t.string :tags,  limit:20
      
    end

    create_table :pictures_tags, :id => false do |t|
      t.integer :picture_id
      t.integer :tag_id
    end

    add_index :pictures_tags, [:picture_id, :tag_id]
  end
end
