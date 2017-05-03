class User < ActiveRecord::Base
  has_many :posts
  has_secure_password

  validates_presence_of :username, :message => 'Please enter a valid username'
  validates_presence_of :email, :message => 'Please enter a valid email'

  validates_uniqueness_of :email, :message => '%{value} has already been taken'
  validates_uniqueness_of :username, :message => '%{value} has already been taken'

end
