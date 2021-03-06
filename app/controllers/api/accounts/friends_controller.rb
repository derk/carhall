class Api::Accounts::FriendsController < Api::Accounts::ApplicationController
  before_filter :set_user

  # GET /api/friends
  # GET /api/friends.json
  def index
    render_index @user.friends
  end

  def user
    render_index @user.user_friends
  end

  def dealer
    render_index @user.dealer_friends
  end

  def provider
    render_index @user.provider_friends
  end

  # POST /api/friends/1
  # POST /api/friends/1.json
  def create
    @user.make_friend_with! params[:id]
    render_created
  end

  # DELETE /api/friends/1
  # DELETE /api/friends/1.json
  def destroy
    @user.break_with! params[:id]
    render_accepted
  end
  
end
