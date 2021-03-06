class Api::Accounts::BlacklistsController < Api::Accounts::ApplicationController
  before_filter :set_user

  # GET /api/blacklists
  # GET /api/blacklists.json
  def index
    render_index @user.blacklists
  end

  # POST /api/blacklists/1
  # POST /api/blacklists/1.json
  def create
    @user.add_to_blacklist! params[:id]
    render_created
  end

  # DELETE /api/blacklists/1
  # DELETE /api/blacklists/1.json
  def destroy
    @user.remove_from_blacklist! params[:id]
    render_accepted
  end
  
end
