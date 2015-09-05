class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.belongs_to :user, index: true, foreign_key: true
      t.belongs_to :account, index: true, foreign_key: true
    end
  end
end
