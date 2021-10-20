class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    
    if not params.keys.include?("header") and params.keys.include?("ratings")
      session[:ratings] = params[:ratings]
    end

    @movies = Movie.with_ratings(session[:ratings])
    @all_ratings = Movie.all_ratings
    @ratings_to_show = Movie.ratings_to_show(session[:ratings])

    if params.keys.include?("header")
      if "title" == params["header"]
        # sort by title
        @movies = @movies.order(:title)
        @color_title = "bg-warning"

      elsif "release_date" == params["header"]
        # sort by release date
        @movies = @movies.order(:release_date)
        @color_date = "bg-warning"

      else
        @movies = Movie.with_ratings(session[:ratings])
      end
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end
