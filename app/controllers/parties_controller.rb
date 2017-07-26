class PartiesController < ApplicationController
  before_action :set_party, only: [:show, :edit, :update, :destroy]

  # GET /parties
  # GET /parties.json
  def index
    @parties = Party.all
  end

  # GET /parties/1
  # GET /parties/1.json
  def show
    unless @party.activated
      @just_created = session[:just_created_party]

      session[:just_created_party] = nil
    else
      redirect_to result_path(Result.find_by_result_name(@party.party_name))
    end
  end

  # GET /parties/new
  def new
    @party = Party.new
  end

  # GET /parties/1/edit
  def edit
  end

  # POST /parties
  # POST /parties.json
  def create
    @party = Party.create(party_name: Party.random_room_code, edit_key: Party.random_edit_key)
    session[:just_created_party] = true
    redirect_to @party
  end

  # PATCH/PUT /parties/1
  # PATCH/PUT /parties/1.json
  def update
    respond_to do |format|
      if @party.update(party_params)
        format.html { redirect_to @party, notice: 'Party was successfully updated.' }
        format.json { render :show, status: :ok, location: @party }
      else
        format.html { render :edit }
        format.json { render json: @party.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parties/1
  # DELETE /parties/1.json
  def destroy
    @party.destroy
    respond_to do |format|
      format.html { redirect_to parties_url, notice: 'Party was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def manage
    @party = Party.find_by_party_name(params[:party_id])
    @activated = @party.activated
    unless params[:key] == @party.edit_key
      redirect_to party_path(@party)
    end
  end

  def add_user
    @party = Party.find_by_party_name(params[:party_id])
    unless @party.usernames.include?(params[:username])
      newusernames = @party.usernames
      newusernames << params[:username]
      @party.update(usernames: newusernames)
    end
    redirect_to :back
  end

  def start
    @party = Party.find_by_party_name(params[:party_id])
    unless @party.usernames.empty?
      analyzer = GithubAnalyzer.new
      session[:multiple_data], percentages = analyzer.analyze_users(@party.usernames)

      if session[:multiple_data] == false
        session[:multiple_data] = nil
        redirect_to :back
        return
      end

      result = Result.create(result_name: @party.party_name, data: session[:multiple_data], practical: true, percentages: percentages)
      @party.update(activated: true)
      redirect_to result_path(result)
    else
      redirect_to :back
    end
  end

  def remove_user
    @party = Party.find_by_party_name(params[:party_id])
    newusernames = @party.usernames
    newusernames.delete_at(params[:index].to_i)
    @party.update(usernames: newusernames)
    redirect_to :back
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_party
      @party = Party.find_by_party_name(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def party_params
      params.fetch(:party, {})
    end
end
