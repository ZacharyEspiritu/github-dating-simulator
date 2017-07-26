class PagesController < ApplicationController
  def home
  end

  def landing

  end

  def analyze
    analyzer = GithubAnalyzer.new
    session[:compatability_data], _ = analyzer.analyze_users([params[:username_1], params[:username_2]]).first

    if session[:compatability_data] == false
      session[:compatability_data] = nil
      redirect_to :back
      return
    end

    result = Result.create(result_name: Result.random_room_code, data: session[:compatability_data])
    redirect_to result_path(result)
  end

  def analysis
    @percentage = session[:compatability_data].first
    @user_1 = UserData.find_by(username: session[:compatability_data].second)
    @user_2 = UserData.find_by(username: session[:compatability_data].third)

    @date_ideas = Array.new
    session[:compatability_data].fourth[0..2].each do |obj|
      @date_ideas << obj
    end

    session[:compatability_data] = nil
  end

  def analyze_multiple
    usernames = []
    if params[:selection_method] == "commas"
      usernames = params[:input].split(",")
    elsif params[:selection_method] == "newlines"
      usernames = params[:input].gsub!(/\r/, '').split("\n")
    else
      usernames = params[:input].split(" ")
    end

    team_limit = 2
    if params[:team_limit] == "two"
      team_limit = 2
    elsif params[:team_limit] == "three"
      team_limit = 3
    elsif params[:team_limit] == "four"
      team_limit = 4
    end

    unless usernames.empty?
      analyzer = GithubAnalyzer.new
      session[:multiple_data], percentages = analyzer.analyze_users(usernames,team_limit)

      if session[:multiple_data] == false
        session[:multiple_data] = nil
        redirect_to :back
        return
      end

      result = Result.create(result_name: Result.random_room_code, data: session[:multiple_data], practical: true, percentages: percentages)
      redirect_to result_path(result)
    else
      redirect_to :back
    end
  end

  def multiple
    @match_data = session[:multiple_data]
    session[:multiple_data] = nil
  end

  def practical
  end
end
