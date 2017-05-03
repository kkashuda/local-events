class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :content, message: "You must enter post content"
end
