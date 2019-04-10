defmodule ExpenseTrackerWeb.ExpenseView do
  use ExpenseTrackerWeb, :view
  alias ExpenseTrackerWeb.ExpenseView

  def render("index.json", %{expenses: expenses}) do
    %{data: render_many(expenses, ExpenseView, "expense.json")}
  end

  def render("show.json", %{expense: expense}) do
    %{data: render_one(expense, ExpenseView, "expense.json")}
  end

  def render("expense.json", %{expense: expense}) do
    %{id: expense.id,
      description: expense.description,
      amount: expense.amount,
      user_id: expense.user_id}
  end
end
