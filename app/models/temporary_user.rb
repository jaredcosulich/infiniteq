class TemporaryUser < ApplicationRecord

  def parsed_votes
    JSON.parse(votes || {'question' => {}, 'answer' => {}}.to_json)
  end

  def add_vote(vote)
    pv = parsed_votes
    topic = vote.topic.downcase
    topic_id = vote.topic_id.to_s
    existing_vote_id = pv[topic][topic_id]
    if (existing_vote = vote.class.find_by(id: existing_vote_id)).present?
      existing_vote.update(trust: vote.trust)
      vote.destroy
    else
      pv[topic][topic_id] = vote.id
      update(votes: pv.to_json)
    end
  end

end
