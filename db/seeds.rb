# Seed some starter habits with sample completions
habits = [
  "Drink 8 glasses of water",
  "Morning stretch",
  "Read for 20 minutes",
  "No screens after 9pm",
  "Journal before bed"
].each_with_index.map do |name, i|
  Habit.find_or_create_by!(name: name) { |h| h.position = i }
end

# Sprinkle some completions over the last 4 weeks
today = Date.current
(0..27).each do |days_ago|
  date = today - days_ago
  habits.each do |habit|
    # ~70% chance of completion, tapering off further back
    chance = 0.7 - (days_ago * 0.01)
    if rand < chance
      habit.habit_completions.find_or_create_by!(completed_on: date)
    end
  end
end

puts "Seeded #{Habit.count} habits with #{HabitCompletion.count} completions."
