class RemovePublishedAtToDiets < ActiveRecord::Migration
  def change
      remove_column :diets, :published_at, :datetime
  end
end
