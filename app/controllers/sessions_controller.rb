class SessionsController < Devise::SessionsController
  before_action :find_user, only: %i(create)

  def create
    if @user
      sign_in_user
    else
      sign_up_user
    end
  end

  def destroy
    head :no_content
  end

  private

  def sign_up_user
    user = User.new(user_params)
    if user.save
      sign_in user
      render json: user, status: :created
    else
      render json: { errors: user.errors }, status: :unprocessable_entity
    end
  end

  def sign_in_user
    user_password = params[:user][:password]
    if @user.valid_password?(user_password)
      sign_in @user
      render json: @user, status: :ok
    else
      render json: {
        errors: I18n.t('devise.failure.invalid', authentication_keys: 'username')
      }, status: :unprocessable_entity
    end
  end

  def find_user
    user_username = params[:user][:username]
    @user = user_username.present? && User.find_by(username: user_username)
  end

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
