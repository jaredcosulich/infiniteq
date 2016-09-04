json.array!(@flags) do |flag|
  json.extract! flag, :id, :reason, :question_id, :answer_id, :user_id, :trust, :details
  json.url flag_url(flag, format: :json)
end
