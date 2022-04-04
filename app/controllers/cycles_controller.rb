class CyclesController < ApplicationController
  def index
    @cycles = Cycle.all.where(public_status: true)
  end
end
