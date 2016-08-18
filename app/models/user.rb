class User < ApplicationRecord
  has_secure_password
  has_many :reviews

  before_create :set_admin

  def set_admin

  end

  def first_user
    self.all.empty?
  end

  def full_name
    "#{firstname} #{lastname}"
  end
end
