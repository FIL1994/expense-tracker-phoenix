defmodule ExpenseTrackerWeb.Router do
  use ExpenseTrackerWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*", allow_headers: ["accept", "content-type"]
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ExpenseTrackerWeb.Auth.Pipeline
    plug :put_user_token
  end

  scope "/api", ExpenseTrackerWeb do
    pipe_through :api
    # resources "/users", UserController, except: [:new, :edit]

    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin

    options "/users/signup", UserController, :create
    options "/users/signin", UserController, :signin
  end

  scope "/api", ExpenseTrackerWeb do
    pipe_through [:api, :auth]
    resources "/expenses", ExpenseController, except: [:new, :edit]
    options "/expenses", ExpenseController, except: [:new, :edit]

    get "/users/socket", UserController, :socket
    options "/users/socket", UserController, :socket
  end

  pipeline :browser do
    plug(:accepts, ["html"])
    plug :put_user_token
  end

  defp put_user_token(conn, _) do
    if current_user = conn.assigns[:current_user] do
      token = Phoenix.Token.sign(conn, "user socket", current_user.id)
      assign(conn, :user_token, token)
    else
      conn
    end
  end
end
