module Votable

  def update_votes
    vote_trust = self.public_send("#{self.class.to_s.downcase}_votes").sum(:trust)
    flag_trust = Flag.grouped(flags).map(&:applicable_trust).inject(:+) || 0
    total_trust = vote_trust - flag_trust
    if user.present? && user.confirmed?
      total_trust += 100
    else
      total_trust += 10
    end
    update_column :vote_total, total_trust
    transition_states
  end

  def transition_states
    return if suspect?
    verify! if vote_total >= 100 and !verified?
    unverify! if vote_total < 100 and !unverified?
  end

  def display_votes
    (vote_total / 10.0).round / 10.0
  end

end
