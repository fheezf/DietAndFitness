class AddNameSurnameHashedPasswordToUsers < ActiveRecord::Migration
  def change
      add_column :users, :name, :string
      add_column :users, :surname, :string
      add_column :users, :hashed_password, :string
  end
end
