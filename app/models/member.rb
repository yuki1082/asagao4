class Member < ActiveRecord::Base
  include EmailAddressChecker
  attr_accessor :password, :password_confirmation
  has_many :entries
  has_one :image, class_name: "MemberImage", dependent: :destroy
  accepts_nested_attributes_for :image, allow_destroy: true
  validates :number, presence: true,
    numericality:{ only_integer: true, greter_than: 0, less_than: 100, allow_blank: true,
                   uniqueness: true }
    validates :name, presence: true,
    format: { with:  /\A[A-Za-z]\w*\z/, allow_blank: true},
    length: { minimum: 2, maximum: 20, allow_blank: true },
    uniqueness: { case_sensitive: false }

  validates :password, presence: { on: :create }, confirmation: { allow_blank: true }
  validates :full_name, length: { maximum: 20 }
  validate :check_email

  def self.search(query)
    rel = order(:number)
    if query.present?
      rel = rel.where("name LIKE ? OR full_name LIKE ?", "%#{query}", "%#{query}")
    end
    rel
  end

  def self.authenticate(name, password)
    member = find_by( name: name)
    if member && member.hashed_password.present? &&
        BCrypt::Password.new(member.hashed_password) == password
      member
    else
      nil
    end
  end

  def password=(val)
    if val.present?
      self.hashed_password = BCrypt::Password.create(val)
    end
    @password = val
  end

  private
  def check_email
    if email.present?
      errors.add(:email, :invalid) unless well_formed_as_email_address(email)
    end
  end

end
