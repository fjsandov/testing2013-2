json.array!(@lodges) do |lodge|
  json.extract! lodge, :name, :lat, :long, :category, :image
  json.url lodge_url(lodge, format: :json)
end
