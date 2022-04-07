class CyclesController < ApplicationController
  def index
    @cycles = Cycle.all
    @invitation = Invitation.new
  end
end
