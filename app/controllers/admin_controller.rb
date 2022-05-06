class AdminController < ApplicationController
  before_action :authenticate_user!
  before_action :test_role
  before_action :find_user, only: %i[show destroy]


  def index
    users = User.all
    if users.present?
      respond_find_user_or_users(User.all)
    else
      render json: {
        status: { code: 404, message: "No one user hasn't been found" }
      }
    end
  end

  def show
    if @user.present?
      respond_find_user(@user)
    else
      respond_not_find_user_by_id
    end
  end

  def destroy
    if @user.present?
      @user.destroy
      respond_destroy_user
    else
      respond_not_find_user_by_id
    end
  end

  def find_by_role
    user = User.find_by(role: params[:role])
    if user.present?
      respond_find_user_or_users(user)
    else
      respond_not_find_user_by_role
    end
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def respond_not_find_user_by_id
    render json: {
      status: { code: 404, message: "User with this id doesn't find" }
    }
  end

  def respond_not_find_user_by_role
    render json: {
      status: { code: 404, message: "User with this role  doesn't exist" }
    }
  end

  def respond_destroy_user
    render json: {
      status: { code: 200, message: "User destroyed" }
    }
  end

  def respond_find_user_or_users(user)
    render json: {
      status: { code: 200 },
      data: user
    }
  end

  def test_role
    unless current_user.role == "admin"
      render json: {
        status: { code: 403, message: "You are forbidden" }
      }
    end
  end


end
