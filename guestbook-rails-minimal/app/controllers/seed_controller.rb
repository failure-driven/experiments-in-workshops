class SeedController < ApplicationController
  def index
    Entry.destroy_all
    redirect_to root_path
  end
end
