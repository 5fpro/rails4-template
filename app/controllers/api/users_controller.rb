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
  def create
    @user = User.new(params.require(:user).permit(:email, :password))
    if @user.save
      render json: { user: @user }
    else
      fail Api::Exception, @user.errors.full_messages
    end
  end
end
