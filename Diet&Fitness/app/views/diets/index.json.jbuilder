json.array!(@diets) do |diet|
  json.extract! diet, :id, :title, :author, :duration, :difficulty, :imagen, :description, :foods, :punctuation
  json.url diet_url(diet, format: :json)
end
