class MoviesController < ApplicationController
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :set_categories
  before_action :admin, except:  %i[index show]

  def index
    @movies = Movie.all.includes(:category).paginate(page: params[:page])
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new movie_params
    @movie.average_rating = 10 unless @movie.average_rating
    if @movie.save
      flash[:success] = "Congratulation! movie was created."
      @movie.active_rates.create(user_id: helpers.current_user.id, rating: @movie.average_rating)
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

  def rates
    @users = Movie.find(params[:id]).users
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow', status: :unprocessable_entity
  end

  private

  def movie_params
    params.require(:movie).permit(:title, :description, :category_id, :average_rating)
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
