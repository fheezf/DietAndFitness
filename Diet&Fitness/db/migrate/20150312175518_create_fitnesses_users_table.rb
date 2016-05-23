class CreateFitnessesUsersTable < ActiveRecord::Migration
  def change
    create_table :fitnesses_users, id: false do |t|
         t.belongs_to :fitness, index: true
         t.belongs_to :user, index: true
    end
  end
end
