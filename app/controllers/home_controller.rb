class HomeController < ApplicationController
  def index
    @problems = Problem.all
    @observations = Observation.all
  end
end
