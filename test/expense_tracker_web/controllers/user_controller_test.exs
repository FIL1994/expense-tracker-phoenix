defmodule ExpenseTrackerWeb.UserControllerTest do
  use ExpenseTrackerWeb.ConnCase

  alias ExpenseTracker.Accounts
  alias ExpenseTracker.Accounts.User

  @create_attrs %{
    email: "some email",
    encrypted_password: "some encrypted_password"
  }
  @update_attrs %{
    email: "some updated email",
    encrypted_password: "some updated encrypted_password"
  }
  @invalid_attrs %{email: nil, encrypted_password: nil, password: nil}

  def fixture(:user) do
    {:ok, user} = Accounts.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  # describe "delete user" do
  #   setup [:create_user]

  #   test "deletes chosen user", %{conn: conn, user: user} do
  #     conn = delete(conn, Routes.user_path(conn, :delete, user))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.user_path(conn, :show, user))
  #     end
  #   end
  # end

  defp create_user(_) do
    user = fixture(:user)
    {:ok, user: user}
  end
end
