defmodule ExpenseTrackerWeb.ExpenseController do
  use ExpenseTrackerWeb, :controller

  alias ExpenseTracker.Expenses
  alias ExpenseTracker.Expenses.Expense
  alias ExpenseTrackerWeb.Auth.Guardian

  action_fallback ExpenseTrackerWeb.FallbackController

  def index(conn, _params) do
    IO.inspect(Guardian.get_user(conn))

    expenses = Expenses.list_expenses()
    render(conn, "index.json", expenses: expenses)
  end

  def create(conn, %{"expense" => expense_params}) do
    #  {:ok, resource, claims} = Guardian.resource_from_token(token) 
    with {:ok, %Expense{} = expense} <- Expenses.create_expense(expense_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.expense_path(conn, :show, expense))
      |> render("show.json", expense: expense)
    end
  end

  def show(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)
    render(conn, "show.json", expense: expense)
  end

  def update(conn, %{"id" => id, "expense" => expense_params}) do
    expense = Expenses.get_expense!(id)

    with {:ok, %Expense{} = expense} <- Expenses.update_expense(expense, expense_params) do
      render(conn, "show.json", expense: expense)
    end
  end

  def delete(conn, %{"id" => id}) do
    expense = Expenses.get_expense!(id)

    with {:ok, %Expense{}} <- Expenses.delete_expense(expense) do
      send_resp(conn, :no_content, "")
    end
  end
end
