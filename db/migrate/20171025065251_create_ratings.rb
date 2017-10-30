class CreateRatings < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :value
      t.references :post, foreign_key: true, on_delete: :cascade

      t.timestamps
    end
  end
end
