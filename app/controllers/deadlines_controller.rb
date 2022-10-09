class DeadlinesController < ApplicationController
  before_action :authenticate_user!

  def index
    @deadlines = Deadline.all
  end
end