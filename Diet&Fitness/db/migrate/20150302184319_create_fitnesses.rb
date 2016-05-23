class CreateFitnesses < ActiveRecord::Migration
  def change
    create_table :fitnesses do |t|
      t.string :title
      t.string :author
      t.string :duration
      t.string :difficulty
      t.datetime :published_at

      t.timestamps
    end
  end
end
