class AddDefaultToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default, :boolean
  end
end
