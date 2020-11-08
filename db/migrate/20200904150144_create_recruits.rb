class CreateRecruits < ActiveRecord::Migration[5.2]
  def change
    create_table :recruits do |t|
      t.references :list, foreign_key: true
      t.string :current #現状
      t.string :media #掲載媒体
      t.string :occupation #職種
      t.timestamps
    end
  end
end
