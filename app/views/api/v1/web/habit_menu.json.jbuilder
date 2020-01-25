# app/views/api/v1/restaurants/index.json.jbuilder
json.array! @habits do |habit|
  json.extract! habit, :id, :title, :description, :cue, :craving, :response, :reward
end