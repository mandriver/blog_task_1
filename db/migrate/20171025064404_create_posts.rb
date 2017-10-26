class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.inet :ip
      t.text :content
      t.references :user, foreign_key: true, index: true

      t.timestamps
    end
  end
end
