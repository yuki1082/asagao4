class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.references :entry, null: false
      t.references :member, null: false
      t.timestamps null: false
    end
    add_index :votes, :entry_id
    add_index :votes, :member_id
  end
end
