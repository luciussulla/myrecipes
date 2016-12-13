class Recipe < ActiveRecord::Base
    
    belongs_to :chef
    validates :chef_id,     presence: true
    validates :name,        presence: true, length: {minimum: 5, maximum: 100}  
    validates :summary,     presence: true, length: {minimum: 5, maximum: 150} 
    validates :description, presence: true, length: {minimum: 5, maximum: 150}
    validate :picture_size
    
    mount_uploader :picture, PictureUploader
    
    private
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end     
    end 
    
end 