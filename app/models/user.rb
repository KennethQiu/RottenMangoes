class User < ApplicationRecord
  has_secure_password
  has_many :reviews
  before_save :default_values

  def first_user
    self.all.empty?
  end

  def full_name
    "#{firstname} #{lastname}"
  end

  def default_values
    self.is_admin ||= false
  end

end
