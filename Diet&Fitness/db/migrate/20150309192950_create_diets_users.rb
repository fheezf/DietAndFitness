class CreateDietsUsers < ActiveRecord::Migration
  def change
    create_table :diets_users, id: false do |t|
         t.belongs_to :diet, index: true
         t.belongs_to :user, index: true
    end
  end
end
