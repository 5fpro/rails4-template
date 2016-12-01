class Api::UsersController < Api::BaseController

  def index
    @users = User.all
    @name = 'abc'
  end

  # GET /api/users/1.json
  def show
    @user = User.find(params[:id])
  end

  # POST /api/users.json
  #   user[email]
  #   user[password]
  def create
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      render json: { user: @user }
    else
      respond_error messages:  @user.errors.full_messages
    end
  end
end
