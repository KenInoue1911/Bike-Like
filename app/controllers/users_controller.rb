class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def index
    # gem ransackによる検索機能
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  # 退会画面
  def unsubscribe
    @user = User
  end

  # 退会機能
  def withdrawal
    @user = User.find(params[:id])
    @user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end


  private

  def user_params
    params.require(:user).permit(:name, :age, :gender, :profile, :bike, :is_deleted)
  end
end
