class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :image_id
      t.integer :user_id
      t.string :post_bike
      t.string :title
      t.text :post_profile

      t.timestamps
    end
  end
end
