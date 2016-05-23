class AddUserIdToFitnesses < ActiveRecord::Migration
  def change
      add_column :fitnesses, :user_id, :integer
  end
end
