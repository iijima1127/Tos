class CreateEpisodes < ActiveRecord::Migration[5.2]
  def change
    create_table :episodes do |t|
      t.string :content
      t.string :variation
      t.references :challenge, foreign_key: true

      t.timestamps
    end
  end
end
