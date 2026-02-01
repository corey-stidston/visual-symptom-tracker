class SymptomsController < ApplicationController
  def index
    @symptoms = Symptom.all
  end

  def new
    @symptom = Symptom.new
  end

  def create
    @symptom = Symptom.new(symptom_params)
    if @symptom.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @symptom = Symptom.find(params[:id])
  end

  def update
    @symptom = Symptom.find(params[:id])
    if @symptom.update(symptom_params)
      redirect_to @symptom
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    @symptom.destroy
    redirect_to root_path
  end

  private
    def symptom_params
      params.expect(symptom: [ :name ])
    end
end
