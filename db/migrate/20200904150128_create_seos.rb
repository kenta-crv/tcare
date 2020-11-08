class CreateSeos < ActiveRecord::Migration[5.2]
  def change
    create_table :seos do |t|
      t.references :list, foreign_key: true
      t.string :rank #ランキング
      t.timestamps
    end
  end
end
