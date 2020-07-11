class EpisodesController < ApplicationController

  def new
    @episode = Challenge.find(params[:id]).episodes.build
  end

  def create
    @episode = Challenge.find(episode_params[:this_challenge_id]).episodes.build(episode_params)
    if @episode.save
      flash[:success] = '新しいエピソードを追加しました'
      redirect_to challenge_path(Challenge.find(episode_params[:this_challenge_id]))
    else
      @user = current_user
      @challenges = @user.challenges.order(id: :desc).page(params[:page]).per(10)
      flash.now[:danger] = '新しいエピソードを追加できませんでした。'
      render :new
    end
  end

  def destroy
    @episode = Episode.find(params[:id])
    @episode.destroy
    flash[:success] = "エピソードを削除しました"
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def episode_params
    params.require(:episode).permit(:variation, :content, :this_challenge_id, :clip, :images)
  end
  
end
