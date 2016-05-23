json.array!(@fitnesses) do |fitness|
  json.extract! fitness, :id, :title, :author, :duration, :difficulty, :imagen, :exercises, :punctuation
  json.url fitness_url(fitness, format: :json)
end
