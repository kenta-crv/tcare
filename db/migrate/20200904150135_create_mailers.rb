class CreateMailers < ActiveRecord::Migration[5.2]
  def change
    create_table :mailers do |t|
      t.references :list, foreign_key: true
      t.string :number
      t.string :title #タイトル
      t.string :select #
      t.string :commit
      t.string :body
      t.timestamps
    end
  end
end
