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
      sign_in user, store: false
      render json: user, status: 201
    else
      render json: { errors: user.errors }, status: 422
    end
  end

  def sign_in_user
    user_password = params[:user][:password]
    if @user.valid_password?(user_password)
      sign_in @user, store: false
      render json: @user, status: 200
    else
      render json: { errors: 'Invalid email or password' }, status: 422
    end
  end

  def find_user
    user_email = params[:user][:email]
    @user = user_email.present? && User.find_by(email: user_email)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
