class AddRepublicanToUsers < ActiveRecord::Migration
  def change
    add_column :users, :republican, :boolean
    add_column :users, :democrat, :boolean
    add_column :users, :jerseyshore, :boolean
  end
end
