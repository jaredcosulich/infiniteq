module Vote

  def display_trust
    (trust / 10.0).round / 10.0
  end

  def positive?
    trust > 0
  end

  def set_trust
    return if positive.blank?
    t = user.present? ? (user.trust > 0 ? (user.trust > 100 ? 100 : user.trust) : 0) : 10
    self.trust = (positive == 'false' ? t * -1 : t)
  end

end
