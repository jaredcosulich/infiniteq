class Flag < ApplicationRecord

  belongs_to :question
  belongs_to :answer
  belongs_to :user

  attr_accessor :action

  validates :reason, presence: true
  validates :action, presence: true

  after_commit :update_object
  after_create :create_trust_event

  scope :persisted, -> { where "id IS NOT NULL" }


  def object
    question || answer
  end

  Reason = Struct.new(:id, :symbol, :text)

  enum reason: [
    :out_of_date,
    :factually_incorrect,
    :factually_debatable,
    :not_relevant,
    :personal_attack,
    :spam
  ]

  def self.reason_strings
    {
      out_of_date: 'Out Of Date',
      factually_incorrect: 'Factually Incorrect',
      factually_debatable: 'Factually Debatable',
      not_relevant: 'Not Relevant / Off Topic',
      personal_attack: 'Personal Attack / Snark',
      spam: 'Spam'
    }
  end

  def reason_string
    Flag.reason_strings[reason.to_sym]
  end

  def display_trust
    (trust / 10.0).round / 10.0
  end


  def self.reason_structs
    reasons.collect do |symbol_string, id|
      symbol = symbol_string.to_sym
      Reason.new(id, symbol, reason_strings[symbol])
    end
  end

  def action_string
    description = []
    if suspect?
      description << "Moved to 'Suspect' tab: #{confirmed.nil? ? 'Pending Review' : 'Comfirmed'}"
    end

    if trust.present?
      description << "#{display_trust} trust points removed."
    end

    description.join(', ')
  end

  private
    def update_object
      object.update_votes
    end

    def create_trust_event
      params = {object_type: 'Flag', object_id: id, event_user: user}
      if object.user.present?
        object.user.trust_events.flag_created.create(
          params.merge(trust: trust / -10.0)
        )
      end

      if user.present?
        user.trust_events.flag_created.create(
          params.merge(trust: 1)
        )
      end
    end


end
