class AddImagenToDiets < ActiveRecord::Migration
  def change
      add_column :diets, :imagen, :string
  end
end
