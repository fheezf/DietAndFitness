class AddExercisesAndDescriptionToFitnesses < ActiveRecord::Migration
  def change
      add_column :fitnesses, :exercises, :string
      add_column :fitnesses, :description, :text
  end
end
