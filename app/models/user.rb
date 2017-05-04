class User < ActiveRecord::Base
  has_many :posts
  has_secure_password

  validates_presence_of :username, :message => 'not valid'
  validates_presence_of :email, :message => 'not valid'

  validates_uniqueness_of :email, :message => '%{value} has already been taken'
  validates_uniqueness_of :username, :message => '%{value} has already been taken'

end
