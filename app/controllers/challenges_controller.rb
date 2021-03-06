class ChallengesController < ApplicationController
  before_action :require_user_logged_in, only: [:new,:create, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  
  def index
    if params[:q] && params[:q].reject { |key, value| value.blank? }.present?
      @q = Challenge.ransack(search_params, activated_true: true)
      @title = "検索結果"
    else
      @q = Challenge.ransack(activated_true: true)
      @title = "全ての挑戦"
    end
    @challenges = @q.result.page(params[:page]).per(10)
  end
  
  def show
    @challenge = Challenge.find(params[:id])
    @episodes = @challenge.episodes.order(id: :desc).page(params[:page]).per(10)
  end
  
  def new
    @challenge = current_user.challenges.build
  end
  
  def create
    @challenge = current_user.challenges.build(challenge_params)
    if @challenge.save
      flash[:success] = '新しい挑戦を追加しました'
      redirect_to user_path(current_user)
    else
      @user = current_user
      @challenges = @user.challenges.order(id: :desc).page(params[:page]).per(10)
      flash.now[:danger] = '新しい挑戦を追加できませんでした。'
      render :new
    end
  end
  
  def edit
    @challenge = Challenge.find(params[:id])
  end
  
  def update
    @challenge = Challenge.find(params[:id])
    if @challenge.update(challenge_params)
      flash[:success] = '挑戦内容は正常に更新されました'
      redirect_to user_path(current_user)
    else
      flash.now[:danger] = '挑戦内容は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @challenge.destroy
    flash[:success] = "挑戦を削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def challenge_params
    params.require(:challenge).permit(:goal, :challenge)
  end
  
  def correct_user
    @challenge = current_user.challenges.find_by(id: params[:id])
    unless @challenge
      redirect_to root_url
    end
  end
  
  def search_params
    params.require(:q).permit(:challenge_cont)
  end
end
