class ChangeTagColumnName < ActiveRecord::Migration
  def change
    rename_column :tags, :tags, :tag
  end
end
