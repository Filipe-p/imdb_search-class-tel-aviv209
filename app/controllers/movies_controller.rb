class MoviesController < ApplicationController

  def index

    if params[:query].present?
    #First way to filter something with a param
      #@movies = Movie.where(title: params[:query])

    #Search and filter with not casse sensitive
      #@movies = Movie.where("title ILIKE ?", "%#{params[:query]}%")

      # sql_query = "title ILIKE :query OR syllabus ILIKE :query"
      # @movies = Movie.where(sql_query, query: "%#{params[:query]}%")


    #ILike search searches similar and with not case sensitive search
      # sql_query = " \
      #   movies.title ILIKE :query \
      #   OR movies.syllabus ILIKE :query \
      #   OR directors.first_name ILIKE :query \
      #   OR directors.last_name ILIKE :query \
      # "
      # @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

    #stronger than ILIKE, has it also handles search words in different order.
      # try to find superman batman,
      #
      sql_query = " \
        movies.title @@ :query \
        OR movies.syllabus @@ :query \
        OR directors.first_name @@ :query \
        OR directors.last_name @@ :query \
      "
      @movies = Movie.joins(:director).where(sql_query, query: "%#{params[:query]}%")

      #@results = PgSearch.multisearch("#{params[:query]}")
    else
      @movies = Movie.all
    end
  end
end









