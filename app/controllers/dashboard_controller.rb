class DashboardController < ApplicationController
  def show
    @week_start = if params[:week_start].present?
      Date.parse(params[:week_start])
    else
      Date.current.beginning_of_week(:monday)
    end
    @week_dates = (0..6).map { |i| @week_start + i }
    @habits = Habit.ordered.includes(:habit_completions)
    @completion_map = build_completion_map(@habits, @week_dates)
    @chart_data = build_chart_data(@habits)
  end

  private

  def build_completion_map(habits, dates)
    date_range = dates.first..dates.last
    completions = HabitCompletion.where(habit: habits, completed_on: date_range)
    completions.each_with_object({}) do |c, map|
      map[[ c.habit_id, c.completed_on ]] = true
    end
  end

  def build_chart_data(habits)
    return {} if habits.empty?

    end_date = Date.current
    start_date = end_date - 27 # 4 weeks
    dates = (start_date..end_date).to_a

    completions = HabitCompletion.where(habit: habits, completed_on: start_date..end_date)
                                 .group(:completed_on)
                                 .count

    total = habits.size
    {
      labels: dates.map { |d| d.strftime("%-d %b") },
      values: dates.map { |d| total > 0 ? ((completions[d] || 0).to_f / total * 100).round : 0 }
    }
  end
end
