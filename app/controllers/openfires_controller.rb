class OpenfiresController < ActionController::Base
  include Api::RenderHelper

  def login
    @user = Account.find_for_database_authentication(mobile: params[:mobile])

    if @user && @user.valid_password?(params[:password])
      @user.ensure_authentication_token!
      render_data openfire_user_info @user
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  def login_by_token
    @user = Account.where(authentication_token: params[:token]).first

    if @user
      @user.ensure_authentication_token!
      render_data openfire_user_info @user
    else
      warden.custom_failure!
      render_error t('devise.failure.invalid'), :unauthorized
    end
  end

  def get_user
    @user = Account.find(params[:id])
    render_data user: openfire_user_detail(@user)
  end

  def list_users
    @users = Account.find(params[:ids].split(','))
    render_data users: @users.includes(:detail).map {|u| openfire_user_detail(u) }
  end

  protected

  def openfire_user_info u
    { id: u.id, mobile: u.mobile, token: u.authentication_token }
  end

  def openfire_user_detail u
    avatar_thumb_url = if u.avatar.present? then Carhall::AbsoluteUrlPrefix + u.avatar.url(:thumb) end
    sex_id = u.detail.sex_id rescue nil
    { 
      id: u.id, username: u.username, mobile: u.mobile, 
      avatar_thumb_url: avatar_thumb_url, sex_id: sex_id || 2
    }
  end
end
