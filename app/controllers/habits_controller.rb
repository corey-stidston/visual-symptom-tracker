class HabitsController < ApplicationController
  before_action :set_habit, only: [ :edit, :update, :destroy ]

  def index
    @habits = Habit.ordered
  end

  def new
    @habit = Habit.new
  end

  def create
    @habit = Habit.new(habit_params)
    @habit.position = (Habit.maximum(:position) || -1) + 1

    if @habit.save
      redirect_to root_path, notice: "Habit created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @habit.update(habit_params)
      redirect_to root_path, notice: "Habit updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @habit.destroy
    redirect_to root_path, notice: "Habit removed."
  end

  private

  def set_habit
    @habit = Habit.find(params[:id])
  end

  def habit_params
    params.expect(habit: [ :name ])
  end
end
