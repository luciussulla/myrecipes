class Chef < ActiveRecord::Base
    has_many :likes
    has_many :recipes 
    
    before_save do 
        self.email = email.downcase
    end 
    
    validates :chefname, presence: true,    length: {minimum: 3, maximum: 100}
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email,    presence: true,    length: {minimum: 6, maximum: 40},
                         uniqueness: {case_sensitive: false},
                         format: {with: VALID_EMAIL_REGEX} 

end