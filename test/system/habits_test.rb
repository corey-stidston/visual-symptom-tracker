require "application_system_test_case"

class HabitsTest < ApplicationSystemTestCase
  test "user can add a habit from dashboard" do
    HabitCompletion.delete_all
    Habit.delete_all

    visit root_path
    within(".text-center") do  # The empty state container
      fill_in "Name your first habit…", with: "Read a book"
      click_on "+ ADD"
    end

    assert_text "Read a book"
    assert_no_text "NO HABITS YET"
  end

  test "user can remove a habit from dashboard" do
    Habit.create!(name: "Exercise")
    visit root_path
    assert_text "Exercise"

    click_on "DELETE", match: :first

    assert_no_text "Exercise"
  end
end
