class AddIngredientsDescriptionToDiets < ActiveRecord::Migration
  def change
      add_column :diets, :ingredients, :string
      add_column :diets, :description, :text
  end
end
