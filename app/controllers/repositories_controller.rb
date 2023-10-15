class RepositoriesController < ApplicationController
  before_action :find_repository, only: [:show, :edit, :update, :destroy]
  
  def index 
    @repositories = Repository.all.order("created_at DESC")
  end

  def show
  end

  def create
    @repository = Repository.new(repository_params)
    if @repository.save
      redirect_to repository_path(@repository.id), notice: "Repository created successfully!" 
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @repository = Repository.update(repository_params)
      redirect_to repository_path, notice: "Repository updated successfully!"
    else
      render :edit
    end
  end

  def destroy
  end

  private 

  def find_repository
    @repository = Repository.find_by(id: params[:id])
  end

  def repository_params
    params.require(:repository).permit(:name, :description, :users => [])
  end
end
