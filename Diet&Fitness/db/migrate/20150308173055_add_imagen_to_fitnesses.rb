class AddImagenToFitnesses < ActiveRecord::Migration
  def change
      add_column :fitnesses, :imagen, :string
  end
end
