class ResultController < ApplicationController
  # before_action :set_user_data, only: [:show, :edit, :update, :destroy]

  # GET /user_data
  # GET /user_data.json
  def index
    # @result = Result.all
  end

  # GET /user_data/1
  # GET /user_data/1.json
  def show
    result = Result.find_by_result_name(params[:id])
    @practical = result.practical
    @result_name = result.result_name

    if @practical
      @match_data = result.data
      @percentages = result.percentages
      session[:multiple_data] = nil
    else
      @percentage = result.data.first
      @user_1 = UserData.find_by(username: result.data.second)
      @user_2 = UserData.find_by(username: result.data.third)

      @date_ideas = Array.new
      if result.data.first == 0
        @date_ideas << "Nothing..."
      else
        result.data.fourth[0..2].each do |obj|
          @date_ideas << obj
        end
      end

      session[:compatability_data] = nil
    end
  end

  def more_data
    result = Result.find_by_result_name(params[:id])

    unless result.practical
      @percentage = result.data.first
      @user_1 = UserData.find_by(username: result.data.second)
      @user_2 = UserData.find_by(username: result.data.third)

      @date_ideas = Array.new
      result.data.fourth[0..2].each do |obj|
        @date_ideas << obj
      end

      session[:compatability_data] = nil
    else
      redirect_to root_path
    end
  end
end
