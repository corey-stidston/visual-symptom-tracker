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
      redirect_to root_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @symptom = Symptom.find(params[:id])
    @symptom.destroy
    redirect_to root_path
  end

  private
    def symptom_params
      params.require(:symptom).permit(
        :name,
        :observation,
        :observed_from,
        :observed_to,
        "observed_from(1i)", "observed_from(2i)", "observed_from(3i)", "observed_from(4i)", "observed_from(5i)",
        "observed_to(1i)", "observed_to(2i)", "observed_to(3i)", "observed_to(4i)", "observed_to(5i)"
      )
    end
end
