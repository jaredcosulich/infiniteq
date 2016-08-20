json.array!(@temporary_users) do |temporary_user|
  json.extract! temporary_user, :id, :ip_address, :votes, :questions, :answers
  json.url temporary_user_url(temporary_user, format: :json)
end
