require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
    
    def setup 
        @chef = Chef.create(chefname: "Jo", email: "example@email.com")
        @recipe = @chef.recipes.build(name: "Chicke farm", summary: "thiis the best cicken farm ever", description: "hheat it oil add onions add tomatosause add ciccek cook for 20 mins")
    end 
    
    test "recipe should be vald" do
        @recipe.chef_id = 1
        assert @recipe.valid? 
    end 
    
    test "chef_id should be present" do 
        @recipe.chef_id = nil
        assert_not @recipe.valid?
    end 
    
    test "name should be present" do 
        @recipe.name = " "
        assert_not @recipe.valid? 
    end 
    
    test "name length should not be too long" do 
        @recipe.name = "a"*101 
        assert_not @recipe.valid? 
    end 
    
    test "name length shoud not be too short" do 
        @recipe.name = "aaaa"
        assert_not @recipe.valid? 
    end 
    
    test "summary shuld be present" do 
        @recipe.summary = " "
        assert_not @recipe.valid?
    end 
    
    test "summery length must not be too long" do 
        @recipe.summary = "a"* 151
        assert_not @recipe.valid?
    end
    
    test "summary length must not be too short" do
        @recipe.summary = "aaaa"
        assert_not @recipe.valid?
    end 
    
    test "description should be present" do 
        @recipe.description = ""
        assert_not @recipe.valid? 
    end 
    
    test "description should not be too long" do 
        @recipe.description = "a" * 151 
        assert_not @recipe.valid? 
    end
    
    test "description should not be too short" do 
        @recipe.description = "aaaa"
        assert_not @recipe.valid? 
    end
end     