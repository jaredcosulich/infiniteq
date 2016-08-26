module Votable

  def update_votes
    total_trust = self.public_send("#{self.class.to_s.downcase}_votes").sum(:trust)
    if user.present?
      total_trust += user.trust
    else
      total_trust += 1
    end
    update_column :vote_total, total_trust
  end

  def transition_states
    verify! if vote_total >= 10 and !verified?
    unverify! if vote_total < 10 and !unverified?
  end

end
