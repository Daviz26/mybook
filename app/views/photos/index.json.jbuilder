json.array!(@photos) do |photo|
  json.extract! photo, :id, :caption, :picture, :user_id
  json.url photo_url(photo, format: :json)
end
