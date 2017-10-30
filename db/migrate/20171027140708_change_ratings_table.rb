class ChangeRatingsTable < ActiveRecord::Migration[5.1]
  def change
    remove_foreign_key :ratings, :posts
    add_foreign_key :ratings, :posts, on_delete: :cascade
  end
end
