defmodule ExpenseTrackerWeb.Router do
  use ExpenseTrackerWeb, :router

  pipeline :api do
    plug CORSPlug, origin: "*", allow_headers: ["accept", "content-type"]
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug ExpenseTrackerWeb.Auth.Pipeline
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
  end

  pipeline :browser do
    plug(:accepts, ["html"])
  end
end
