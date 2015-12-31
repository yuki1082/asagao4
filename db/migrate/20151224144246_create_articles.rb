class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
    	t.string :title , null: false
    	t.string :body, null: false
    	t.datetime :released_at, null: false
    	t.datetime :expired_at
    	t.boolean :member_only, null: false, default: 0

      t.timestamps null: false
    end
  end
end
