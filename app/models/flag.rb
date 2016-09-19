class GroupedFlag

  def initialize(flags)
    @flags = flags
  end

  def flags
    @flags
  end

  def not_disputing
    @flags.select { |f| !f.dispute? }
  end

  def disputing
    @flags.select { |f| f.dispute? }
  end

  def trust
    @flags.map(&:trust).inject(:+) || 0
  end

  def display_trust
    (trust / 10.0).round / 10.0
  end

  def valid?
    not_disputing.length > 0
  end

  def applicable_trust
    [0, trust].max
  end

  def action_string
    description = []
    if (suspect_flags = @flags.select(&:suspect?)).present?
      any_confirmed = suspect_flags.select(&:confirmed?)
      description << "Moved to 'Suspect' tab: #{any_confirmed.empty? ? 'Pending Review' : 'Comfirmed'}"
    end

    if trust > 0
      description << "#{display_trust.abs} trust points #{dispute? ? 'added back' : 'removed'}."
    end

    description.join(', ')
  end

  def disputed?
    trust <= 0
  end

  def detailed_flags
    @flags.select { |f| f.details.present? }
  end

  def method_missing(name, *args, &block)
    @flags.first.send(name, *args, &block)
  end
end

class GroupedFlags
  def initialize(flags)
    @grouped_flags = []
    flags.group_by(&:reason).each do |reason, group|
      grouped_flag = GroupedFlag.new(group)
      @grouped_flags << grouped_flag if grouped_flag.valid?
    end
  end

  def not_disputed
    @grouped_flags.select { |gf| !gf.disputed? }
  end

  def disputed
    @grouped_flags.select { |gf| gf.disputed? }
  end

  def method_missing(name, *args, &block)
    @grouped_flags.send(name, *args, &block)
  end
end

Reason = Struct.new(:id, :symbol, :text)

class Flag < ApplicationRecord

  belongs_to :question
  belongs_to :answer
  belongs_to :user
  has_many :trust_events, -> { where(object_type: 'Flag') }, foreign_key: :object_id, dependent: :destroy

  attr_accessor :action

  validates :reason, presence: {message: '(please provide a reason for flagging)'}
  validates :action, presence: {message: '(please provide an action to take)'}

  before_save :take_action
  after_commit :update_object
  after_create :create_trust_event

  scope :persisted, -> { where "id IS NOT NULL" }

  def object
    question || answer
  end

  def user_name
    user.present? ? user.name : 'Anonymous'
  end

  def self.grouped(flags)
    GroupedFlags.new(flags.select(&:persisted?))
  end

  def group
    Flag.grouped(object.flags).select { |gf| gf.reason == reason }.first
  end

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
      description << "#{display_trust.abs} trust points #{dispute? ? 'added back' : 'removed'}."
    end

    description.join(', ')
  end

  private
    def update_object
      object.update_votes
      object.mark_suspect! if suspect?
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

    def take_action
      self.suspect = true if action == 'suspect'
    end


end
