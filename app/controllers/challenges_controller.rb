class ChallengesController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
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
      render template: "users/show"
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
end
