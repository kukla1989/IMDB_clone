class RatesController < ApplicationController
  def create
    @movie = Movie.find(params.require(:movie_id).to_i)
    user_id = helpers.current_user.id
    rate = Rate.find_by(movie_id: @movie.id, user_id: user_id)
    if rate
      rate.update(rating: rate_params[:rating].to_i)
    else
      @movie.active_rates.create(rating: rate_params[:rating].to_i, user_id: user_id)
    end
    rates = Rate.where(movie_id: @movie)
    @movie.average_rating = rates.inject(0){|acc, el| acc + el.rating} / rates.length
    @movie.save
    respond_to do |format|
      format.turbo_stream
      format.html {redirect_to request.referrer}
    end
  end

  private

  def rate_params
    params.require(:rate).permit(:rating)
  end
end
