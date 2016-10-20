class Borrower < ActiveRecord::Base
  has_secure_password
  after_initialize :default_values, unless: :persisted?
  has_many :lendings
  has_many :borrowing_from, through: :lendings, source: :lender
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :email, :project, :desc, :ammount_needed, presence: true
  validates :email, presence:true, uniqueness: {case_sensitive: false}, format:{with:EMAIL_REGEX}
  validate :unique_email
  def unique_email
    self.errors.add(:email, 'is already taken') if Lender.where(email: self.email).exists?
  end
  def default_values
    self.ammount_raised = 0
  end
end
