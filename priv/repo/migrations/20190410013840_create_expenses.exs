defmodule ExpenseTracker.Repo.Migrations.CreateExpenses do
  use Ecto.Migration

  def change do
    create table(:expenses) do
      add :description, :string
      add :amount, :float
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:expenses, [:user_id])
  end
end
