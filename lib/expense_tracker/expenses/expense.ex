defmodule ExpenseTracker.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :amount, :float
    field :description, :string
    belongs_to :user, ExpenseTracker.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:description, :amount, :user_id])
    |> validate_required([:description, :amount, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
