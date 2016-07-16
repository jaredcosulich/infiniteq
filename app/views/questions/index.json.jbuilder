json.array!(@questions) do |question|
  json.extract! question, :id, :text, :details, :topic_id, :user_id
  json.url question_url(question, format: :json)
end
