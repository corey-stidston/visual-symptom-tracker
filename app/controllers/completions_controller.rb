class CompletionsController < ApplicationController
  def create
    habit = Habit.find(params[:habit_id])
    date = Date.parse(params[:completed_on])
    completion = habit.habit_completions.find_by(completed_on: date)

    if completion
      completion.destroy
    else
      habit.habit_completions.create!(completed_on: date)
    end

    respond_to do |format|
      format.turbo_stream do
        completed = habit.habit_completions.exists?(completed_on: date)
        habits = Habit.ordered.includes(:habit_completions)
        week_start = params[:week_start].present? ? Date.parse(params[:week_start]) : Date.current.beginning_of_week(:monday)
        chart_data = build_chart_data(habits)

        render turbo_stream: [
          turbo_stream.replace(
            "completion-#{habit.id}-#{date.iso8601}",
            partial: "dashboard/completion_cell",
            locals: { habit: habit, date: date, completed: completed, week_start: week_start }
          ),
          turbo_stream.replace(
            "consistency-chart",
            partial: "dashboard/consistency_chart",
            locals: { chart_data: chart_data }
          )
        ]
      end
      format.html { redirect_back fallback_location: root_path }
    end
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
    start_date = end_date - 27
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
