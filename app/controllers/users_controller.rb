class UsersController < ApplicationController
  def index
    @users = User.order(id: :desc).page(params[:page]).per(24)
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザ登録が完了しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      flash.now[:danger] = "ユーザー情報の更新に失敗しました"
      render :edit
    end
  end

  def destory
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email,:profile,:avatar, :password, :password_confirmation)
  end
end
