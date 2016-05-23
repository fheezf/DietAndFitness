class AddPunctuationToDiets < ActiveRecord::Migration
  def change
      add_column :diets, :punctuation, :integer, :default => 0
  end
end
