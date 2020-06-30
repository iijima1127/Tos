class RelationshipsController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    user = User.find(params[:influence_id])
    current_user.influence(user)
    flash[:success] = "このユーザーをインフルしました"
    redirect_to user
  end

  def destroy
    user = User.find(params[:influence_id])
    current_user.uninfluence(user)
    flash[:success] = "このユーザーのインフルを解除しました"
    redirect_to user
  end
end
