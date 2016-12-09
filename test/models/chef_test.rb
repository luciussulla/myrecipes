require 'test_helper'

class ChefTest < ActiveSupport::TestCase
    
    def setup
        @chef = Chef.new(chefname: "johnny", email: "johnny@example.com")
    end 
    
    test "chef should be valid" do 
        assert @chef.valid? 
    end 
    
    test "chefname should be present" do 
        @chef.chefname = " "
        assert_not @chef.valid? 
    end 
    
    test "chefname should not be too long" do 
        @chef.chefname = "a" * 101 
        assert_not @chef.valid? 
    end 
    
    test "chenname should not be too short " do 
        @chef.chefname = "aa"
        assert_not @chef.valid? 
    end 
    
    test "email should be not too long" do 
        @chef.email = "a"*50 + "@example.com"
        assert_not @chef.valid?
    end 
    
    test "email should not be too sort" do 
        @chef.email = "a" + "@x.c"
        assert_not @chef.valid?
    end 
    
    test "email shoudl be unique" do 
        @chef.save
        chef_dup = @chef.dup 
        chef_dup.email = @chef.email.upcase
        assert_not chef_dup.valid?
    end 
    
    test "email validation should accpt valid addreses" do 
        valid_addresses = %w[user@eee.com R_TDD-DS@eee.hello.com user@example.com first.last@eem.au laura+joe@monk.cm]    
        valid_addresses.each do |va| 
            @chef.email = va
            assert @chef.valid?, '#{va.inspect is valid}'
        end     
    end 
    
    test "invalid addresses should not be accepted" do 
        invalid_addresses = %w[something@hello,com user_at_eee.com user.name@example. eee_i@am_.com email@foo+eee.com]
        invalid_addresses.each do |ia| 
          @chef.email = ia
          assert_not @chef.valid?, '#{ia.inspect is invalid}' 
        end 
    end 
    
end  