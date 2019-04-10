defmodule ExpenseTrackerWeb.Router do
  use ExpenseTrackerWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ExpenseTrackerWeb do
    pipe_through :api
    # resources "/users", UserController, except: [:new, :edit]
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
    resources "/expenses", ExpenseController, except: [:new, :edit]
  end
end
