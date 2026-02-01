class HomeController < ApplicationController
  def index
    @symptoms = Symptom.all
  end
end
