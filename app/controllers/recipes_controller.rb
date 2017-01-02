class RecipesController < ApplicationController
    
    before_action :set_recipe, only: [:edit, :update, :show, :like]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update]
    
    def index
        @recipes = Recipe.paginate(page: params[:paginate], per_page: 3)
        #@recipes = Recipe.all.sort_by {|likes| likes.thumbs_up_total}.reverse
    end 
    
    def show
    end 
 
    def new
        @recipe = Recipe.new
    end 
    
    def create 
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = current_user
        if @recipe.save
            flash[:success] = "You have created a new recipe"
            redirect_to recipes_path
        else
            flash[:danger] = "You have not created a recipe"
            render :new
        end 
    end 
    
    def like
        @recipe = Recipe.find(params[:id])
        like = Like.create(like: params[:like], chef_id: current_user.id , recipe_id: @recipe.id)
        if like.valid?
            flash[:success] = "your selection was successful"
            redirect_to :back
        else 
            flash[:danger] = "You can only like a recipe once" 
            redirect_to :back
        end
    end 
    
    def edit 
    end 
    
    def update 
        @recipe = Recipe.find(params[:id])
        if @recipe.update(recipe_params)
            flash[:success] = "your recipe was updated successfully"
            redirect_to @recipe
        else 
            flash[:danger] = "your recipe was not updated"
            render :new
        end     
    end 
    
    private 
    
    def recipe_params
        params.require(:recipe).permit(:name, :summary, :description, :picture)
    end 
    
    def set_recipe
        @recipe = Recipe.find(params[:id])
    end 
    
    def require_same_user
        if current_user != @recipe.chef
            flash[:danger]  = "You can only edit your own recipes"
            redirect_to recipes_path
        end     
    end 
end 