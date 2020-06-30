class EpisodesController < ApplicationController

  def new
    @episode = Challenge.find(params[:id]).episodes.build
  end

  def create
    @episode = Challenge.find(episode_params[:this_challenge_id]).episodes.build(episode_params)
    if @episode.save
      flash[:success] = '新しいエピソードを追加しました'
      redirect_to user_path(current_user)
    else
      @user = current_user
      @challenges = @user.challenges.order(id: :desc).page(params[:page]).per(10)
      flash.now[:danger] = '新しいエピソードを追加できませんでした。'
      render template: "challenges/show"
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
  private
  
  def episode_params
    params.require(:episode).permit(:variation, :content, :this_challenge_id)
  end
end
