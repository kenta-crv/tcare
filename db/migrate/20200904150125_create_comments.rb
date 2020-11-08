class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.references :list, foreign_key: true
      t.string :body #コメント
      t.timestamps
    end
  end
end
