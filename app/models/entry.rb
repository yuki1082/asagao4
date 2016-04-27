class Entry < ActiveRecord::Base
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member
  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: {maximum: 200}
  validates :body, :posted_at, presence: true
  validates :status, inclusion:{in: STATUS_VALUES}

  scope :commom, -> {where(status: "public")}
  scope :published, ->{where("status <> ?", "draft")}
  scope :full, ->(member){where("status <> ? OR member_id = ?", "draft", member.id)}

  scope :readable_for, ->(member) { member ? full(member) : commom}

  def self.status_text(status)
    I18n.t("activerecord.attributes.entry.status_#{status}")
  end

  def self.status_options
    STATUS_VALUES.map { |status| [status_text(status), status] }
  end

  def self.sidebar_entries(member, num = 5)
    readable_for(member).order(posted_at: :desc).limit(num)
  end

end
