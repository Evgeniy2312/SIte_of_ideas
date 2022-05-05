# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  before_action :authenticate_user!

  respond_to :json
  # before_action : configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  def create
    return respond_to_on_registration if params[:user][:role] == 'admin'

    super
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  def update_password
    if current_user.present? && test_password(params[:user])
      current_user.update(encrypted_password: BCrypt::Password.create(params[:user][:password]))
      respond_to_password_change
    else
      respond_to_password_not_change
    end
  end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def test_password(user)
    BCrypt::Password.new(current_user.encrypted_password) == (user[:current_password]) &&
      user[:password] == user[:password_confirmation]
  end

  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: { code: 200, message: 'Signed up successfully.' },
        data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
      }
    else
      render json: {
        status: { message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}" }
      }, status: :unprocessable_entity
    end
  end

  def respond_to_on_registration
    render json: {
      status: 405,
      message: 'Registration admin cancel'
    }, status: :method_not_allowed
  end

  def respond_to_password_change
    render json: {
      status: 200,
      message: 'Password changed successfully'
    }, status: :ok
  end

  def respond_to_password_not_change
    render json: {
      status: 400,
      message: 'Error in changing password'
    }, status: :bad_request
  end

end