class ChartController < ApplicationController
  def index
    @symptoms = Symptom.all
  end
end
