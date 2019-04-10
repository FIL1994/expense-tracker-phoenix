defmodule ExpenseTrackerWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :expense_tracker,
    module: ExpenseTrackerWeb.Auth.Guardian,
    error_handler: ExpenseTrackerWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
