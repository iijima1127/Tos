class CreateRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :relationships do |t|
      t.references :user, foreign_key: true
      t.references :influence, foreign_key: { to_table: :users }

      t.timestamps
      t.index [:user_id, :influence_id], unique: true
    end
  end
end