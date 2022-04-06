require "pry-byebug"

class InvitationsController < ApplicationController
  def new

    @cycle = Cycle.find(params[:cycle_id])
    @invitation = Invitation.new
    @invitation.cycle = @cycle
    respond_to do |format|
      format.js
    end
  end

  def create
    @invitation = Invitation.new(invitation_params)
    @cycle = Cycle.find(params[:cycle_id])
    @invitation.cycle = @cycle
    @invitation.save!
    # if @invitation.save
    #   redirect_to '/'
    # else
    #   render 'invitation/new'
    # end
  end

  private

  def invitation_params
    params.require(:invitation).permit(:email, :message)
  end
end
