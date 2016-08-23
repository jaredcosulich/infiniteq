class TemporaryUser < ApplicationRecord


  def add_vote(vote)
    parsed_votes = JSON.parse(votes || {'question' => {}, 'answer' => {}}.to_json)

    topic = vote.topic.downcase
    topic_id = vote.topic_id.to_s
    existing_vote_id = parsed_votes[topic][topic_id]
    if (existing_vote = vote.class.find_by(id: existing_vote_id)).present?
      existing_vote.update(trust: vote.trust)
      vote.destroy
    else
      parsed_votes[topic][topic_id] = vote.id
      update(votes: parsed_votes.to_json)
    end
  end

end
