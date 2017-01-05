class Recipe < ActiveRecord::Base
    has_many :likes, dependent: :destroy
    belongs_to :chef
    
    has_many :recipe_styles, dependent: :destroy
    has_many :styles, through: :recipe_styles
    
    has_many :recipe_ingredients, dependent: :destroy
    has_many :ingredients, through: :recipe_ingredients
    
    validates :chef_id,     presence: true
    validates :name,        presence: true, length: {minimum: 5, maximum: 100}  
    validates :summary,     presence: true, length: {minimum: 5, maximum: 150} 
    validates :description, presence: true, length: {minimum: 5, maximum: 150}
    validate :picture_size
    
    mount_uploader :picture, PictureUploader
    
    default_scope -> {order(created_at: :desc)}
    
    def thumbs_up_total
        self.likes.where(like: true).size
    end 
    
    def thumbs_down_total
        self.likes.where(like: false).size
    end 
    
    private
    def picture_size
        if picture.size > 5.megabytes
            errors.add(:picture, "should be less than 5MB")
        end     
    end 
    
end 