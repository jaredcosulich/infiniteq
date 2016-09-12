class TemporaryUser < ApplicationRecord

  def voted_on?(object, positive)
    object_type = object.class.to_s.downcase
    return positive == true if (public_send("parsed_#{object_type}s") || {})[object.id.to_s].present?
    vote_id = parsed_votes[object_type][object.id.to_s]
    return false if vote_id.nil?
    vote = object.public_send("#{object_type}_votes").find(vote_id)
    positive == vote.try(:trust) > 0
  end

  def has_flagged?(object)
    flag_id_for(object).present?
  end

  def flag_id_for(object)
    parsed_flags[object.class.to_s.downcase][object.id.to_s]
  end

  def flag_for(object)
    Flag.find(flag_id_for(object))
  end

  def self.add_object(object, remote_ip)
    temporary_user = TemporaryUser.find_or_create_by(ip_address: remote_ip)
    if object.class.to_s =~ /Vote/
      temporary_user.add_vote(object)
    else
      temporary_user.public_send("add_#{object.class.to_s.downcase}", object)
    end
    return temporary_user
  end

  def remove_object(object)
    if object.class.to_s =~ /Vote/
      remove_vote(object)
    else
      public_send("remove_#{object.class.to_s.downcase}", object)
    end
  end

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

  def parsed_questions
    JSON.parse(questions || {}.to_json)
  end

  def add_question(question)
    pq = parsed_questions
    pq[question.id.to_s] = true
    update(questions: pq.to_json)
  end

  def parsed_answers
    JSON.parse(answers || {}.to_json)
  end

  def add_answer(answer)
    pa = parsed_answers
    pa[answer.id.to_s] = true
    update(answers: pa.to_json)
  end

  def parsed_flags
    JSON.parse(flags || {'question' => {}, 'answer' => {}}.to_json)
  end

  def add_flag(flag)
    pf = parsed_flags
    if flag.question_id.present?
      pf['question'][flag.question_id.to_s] = flag.id
    else
      pf['answer'][flag.answer_id.to_s] = flag.id
    end
    update(flags: pf.to_json)
  end

  def remove_flag(flag)
    pf = parsed_flags
    if flag.question_id.present?
      pf['question'].delete flag.question_id.to_s
    else
      pf['answer'].delete flag.answer_id.to_s
    end
    update(flags: pf.to_json)
  end
end
