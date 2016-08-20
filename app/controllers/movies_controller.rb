class MoviesController < ApplicationController

  def index 
    @movies = Movie.all
    @movies = @movies.title_is(params[:title]) if params[:title].present?
    @movies = @movies.director_is(params[:director]) if params[:director].present?
    @movies = @movies.contains(params[:q]) if params[:q].present?
    case params[:runtime]
    when 'short'
      @movies = @movies.is_short
    when 'medium'
      @movies = @movies.is_medium 
    when 'long'    
      @movies = @movies.is_long
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def update
    @movie = Movie.find(params[:id])
    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :remote_image_url, :description, :image, :remove_image
    )
  end

end

