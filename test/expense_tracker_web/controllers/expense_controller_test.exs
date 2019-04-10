defmodule ExpenseTrackerWeb.ExpenseControllerTest do
  use ExpenseTrackerWeb.ConnCase

  alias ExpenseTracker.Expenses
  alias ExpenseTracker.Expenses.Expense

  @create_attrs %{
    amount: 120.5,
    description: "some description"
  }
  @update_attrs %{
    amount: 456.7,
    description: "some updated description"
  }
  @invalid_attrs %{amount: nil, description: nil}

  def fixture(:expense) do
    {:ok, expense} = Expenses.create_expense(@create_attrs)
    expense
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get(conn, Routes.expense_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create expense" do
    test "renders expense when data is valid", %{conn: conn} do
      conn = post(conn, Routes.expense_path(conn, :create), expense: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.expense_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 120.5,
               "description" => "some description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.expense_path(conn, :create), expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update expense" do
    setup [:create_expense]

    test "renders expense when data is valid", %{conn: conn, expense: %Expense{id: id} = expense} do
      conn = put(conn, Routes.expense_path(conn, :update, expense), expense: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.expense_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => 456.7,
               "description" => "some updated description"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, expense: expense} do
      conn = put(conn, Routes.expense_path(conn, :update, expense), expense: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete expense" do
    setup [:create_expense]

    test "deletes chosen expense", %{conn: conn, expense: expense} do
      conn = delete(conn, Routes.expense_path(conn, :delete, expense))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.expense_path(conn, :show, expense))
      end
    end
  end

  defp create_expense(_) do
    expense = fixture(:expense)
    {:ok, expense: expense}
  end
end
