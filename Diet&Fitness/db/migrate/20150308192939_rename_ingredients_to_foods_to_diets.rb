class RenameIngredientsToFoodsToDiets < ActiveRecord::Migration
  def change
      rename_column :diets, :ingredients, :foods
  end
end
