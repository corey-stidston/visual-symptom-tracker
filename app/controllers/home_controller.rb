class HomeController < ApplicationController
  def index
    @problems = Problem.all
    @observations = Observation.all

    @chart_data = @observations.map do |observation|
      [ observation.observed.iso8601, observation.score ]
    end
  end
end
