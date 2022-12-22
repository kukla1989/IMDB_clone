class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :set_categories
  before_action :admin, only: %i[edit update destroy]

  def index
    @movies = Movie.all.paginate(page: params[:page])
  end


  def new
    @movie = Movie.new
  end


  def create
    @movie = Movie.new movie_params
    if @movie.save
      flash[:success] = "Congratulation! movie was created."
      redirect_to @movie
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show; end

  def edit; end

  def update
    if @movie.update(movie_params)
      redirect_to @movie
    else
      render "edit", status: :unprocessable_entity
    end
  end

  def destroy
    @movie.destroy
    flash[:success] = "movie was destroed"
    redirect_to root_url, status: :see_other
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :category_id)
  end

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def set_categories
    @categories = Category.all.order(:title)
  end

  def admin
    redirect_to root_path, status: :see_other unless helpers.admin?
  end
end
