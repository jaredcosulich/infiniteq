json.array!(@question_votes) do |question_vote|
  json.extract! question_vote, :id, :question_id, :user_id, :trust
  json.url question_vote_url(question_vote, format: :json)
end
