class RecipesController < ApplicationController
    
    def index
        @recipes = Recipe.all
    end 
    
    def show
        @recipe = Recipe.find(params[:id])
    end 

    def new
        @recipe = Recipe.new
    end 
    
    def create 
        @recipe = Recipe.new(recipe_params)
        @recipe.chef = Chef.find(2)
        if @recipe.save
            flash[:success] = "You have created a new recipe"
            redirect_to recipes_path
        else
            flash[:danger] = "You have not created a recipe"
            render :new
        end 
    end 
    
    def edit 
        @recipe = Recipe.find(params[:id])
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
    
end 