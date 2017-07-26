class UserDataController < ApplicationController
  before_action :set_user_data, only: [:show, :edit, :update, :destroy]

  # GET /user_data
  # GET /user_data.json
  def index
    @user_data = UserData.all
  end

  # GET /user_data/1
  # GET /user_data/1.json
  def show
  end

  # GET /user_data/new
  def new
    @user_data = UserData.new
  end

  # GET /user_data/1/edit
  def edit
  end

  # POST /user_data
  # POST /user_data.json
  def create
    @user_data = UserData.new(user_data_params)

    respond_to do |format|
      if @user_data.save
        format.html { redirect_to @user_data, notice: 'User data was successfully created.' }
        format.json { render :show, status: :created, location: @user_data }
      else
        format.html { render :new }
        format.json { render json: @user_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_data/1
  # PATCH/PUT /user_data/1.json
  def update
    respond_to do |format|
      if @user_data.update(user_data_params)
        format.html { redirect_to @user_data, notice: 'User data was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_data }
      else
        format.html { render :edit }
        format.json { render json: @user_data.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_data/1
  # DELETE /user_data/1.json
  def destroy
    @user_data.destroy
    respond_to do |format|
      format.html { redirect_to user_data_url, notice: 'User data was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_data
      @user_data = UserData.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_data_params
      params.require(:user_data).permit(:username, :data)
    end
end
