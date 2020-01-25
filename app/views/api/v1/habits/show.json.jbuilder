# app/views/api/v1/habits/show.json.jbuilder
json.extract! @habit, :id, :title, :description, :cue, :craving, :response, :reward
