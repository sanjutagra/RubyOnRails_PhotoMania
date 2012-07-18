class CreatePhotos < ActiveRecord::Migration
  def self.up 
	drop_table :photos
    create_table :photos do |t|
      t.column :description, :string
      t.column :content_type, :string 
      t.column :filename, :string 
      t.column :binary_data, :binary
	t.column :album_id,:integer 
      t.timestamps
    end
	add_index :photos, :album_id
  end
end
