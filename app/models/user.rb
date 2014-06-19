class User < ActiveRecord::Base
  authenticates_with_sorcery!
  
  validates :username, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :honorific, presence: true
  validates :email, presence: true
  validates :phone_number, presence: true
  validates :phone_number, format: { with: /\(\d{3}\) \d{3}-\d{4}/, message: "format must be (xxx) xxx-xxxx" }
  
  has_one :position
  
  def self.admin_user
    User.where(:admin => true).first
  end
  
  def full_name
    "#{first_name} #{last_name}"
  end
  
  def honorific_name
    "#{honorific} #{last_name}"
  end
  
end