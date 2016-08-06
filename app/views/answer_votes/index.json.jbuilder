json.array!(@answer_votes) do |answer_vote|
  json.extract! answer_vote, :id, :answer_id, :user_id, :trust
  json.url answer_vote_url(answer_vote, format: :json)
end
