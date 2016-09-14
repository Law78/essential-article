class Article < ActiveRecord::Base
  
  validates :title, length: { minimum: 5 }
  validates :title, uniqueness: { message: "Titolo già presente" }
  validates :body, length: { minimum: 15 }
  
  belongs_to :user
  has_many :comments
end
