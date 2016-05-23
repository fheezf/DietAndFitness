class RemovePublishedAtToFitnesses < ActiveRecord::Migration
  def change
      remove_column :fitnesses, :published_at, :datetime
  end
end
