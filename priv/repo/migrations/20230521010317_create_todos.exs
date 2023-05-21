defmodule TodoFamily.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos, primary_key: false) do
      add :id, :uuid, primary_key: true
      add :description, :string
      add :done, :boolean, default: false, null: false
      add :list_id, references(:lists, on_delete: :nothing, type: :uuid), null: false

      timestamps()
    end

    create index(:todos, [:list_id])
  end
end
