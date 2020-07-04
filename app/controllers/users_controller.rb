class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:edit, :update]
  before_action :admin_user, only: [:edit, :update]
  
  def index
    @users = User.order(id: :desc).page(params[:page]).per(24)
  end

  def show
    @user = User.find(params[:id])
    @challenge = @user.challenges.build
    @challenges = @user.challenges.order(id: :desc).page(params[:page]).per(10)
    counts(@user)
  end

  def new
    @user = User.new
  end

  def create
   @user = User.new(user_params)
    if @user.save
      flash[:success] = 'ユーザ登録が完了しました。'
      redirect_to root_url
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
  
  def rank
    @users = User.find(Relationship.group(:influence_id).order('count(influence_id) desc').limit(10).pluck(:influence_id))
  end
  
  def influencers
    @user = User.find(params[:id])
    counts(@user)
  end
  
  private
  
  def user_params
    params.require(:user).permit(:name, :email,:profile,:avatar, :password, :password_confirmation)
  end
  #↓途中　編集を特定のユーザーだけができるようにしたいけど
  def admin_user
    @user = current_user.id
    unless @user
      redirect_to root_url
    end
  end
end
