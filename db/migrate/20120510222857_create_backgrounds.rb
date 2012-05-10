class CreateBackgrounds < ActiveRecord::Migration
  def change
    create_table :backgrounds do |t|
      t.string :author
      t.string :author_link
      t.string :flickr
      t.string :naked
      t.integer :cc_type

      t.timestamps
    end
  end
end
