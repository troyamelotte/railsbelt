class Lender < ActiveRecord::Base
  has_secure_password
  has_many :lendings
  has_many :lending_to, through: :lendings, source: :borrower
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, presence: true
  validates :email, presence:true, uniqueness: {case_sensitive: false}, format:{with:EMAIL_REGEX}
  validate :unique_email
  def unique_email
    self.errors.add(:email, 'is already taken') if Borrower.where(email: self.email).exists?
  end
end
