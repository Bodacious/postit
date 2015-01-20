class VotesController < ApplicationController
  
  def create
    if vote.save
      flash[:notice] = "Your vote was counted"
    else
      flash[:danger] = "You can only vote once"
    end    
    redirect_to :back
  end
  
  
  private
  
  
  def vote
    @vote ||= Vote.new(voteable: post, creator: current_user, vote: params[:vote])
  end
  
  def post
    @post ||= Post.find(params[:post_id])
  end
  
end
