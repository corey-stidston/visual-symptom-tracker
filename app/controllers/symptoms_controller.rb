class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.all
  end

  def show
    @symptom = Symptom.find(params[:id])
  end

  def new
    @symptom = Symptom.new
  end

  def create
    @symptom = Symptom.new(symptom_params)
    if @symptom.save
      redirect_to @symptom
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
    def symptom_params
      params.expect(symptom: [ :name ])
    end
end
