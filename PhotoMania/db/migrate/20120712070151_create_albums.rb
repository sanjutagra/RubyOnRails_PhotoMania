class CreateAlbums < ActiveRecord::Migration
  def change
	drop_table :albums
    create_table :albums do |t|
      t.string :aname
	t.column :user_id, :integer
      t.timestamps
    end
	add_index :albums, :user_id
  end
end
