class Article < ActiveRecord::Base
  validates :title, :body, :released_at, presence: true
  validates :title, length: { maximum: 200 }
  validate :check_expired_at
  before_validation :clear_expired_at

  scope :open, ->{
    now = Time.current
    where("released_at <= ? AND (? < expired_at OR  expired_at IS NULL)", now, now) }

  scope :readable_for, ->(member){
    member ? all : where(member_only: false)}


  def no_expiration
    expired_at.blank?
  end

  def no_expiration=(val)
    @no_expiration = val.in?([true, 1, "1"])
  end

  def self.sidebar_articles(member, num = 5)
    open.readable_for(member).order(released_at, "desc").limit(num)
  end 

  private
  def check_expired_at
    if expired_at && expired_at < released_at
      errors.add(:expired_at, :expired_at_too_old)
    end
  end


  def clear_expired_at
    self.expired_at = nil if @no_expiration
  end


end
