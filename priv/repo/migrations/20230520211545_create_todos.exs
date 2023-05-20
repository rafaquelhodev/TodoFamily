defmodule TodoFamily.Repo.Migrations.CreateTodos do
  use Ecto.Migration

  def change do
    create table(:todos) do
      add :uuid, :uuid, null: false, default: fragment("gen_random_uuid()")
      add :description, :string
      add :done, :boolean, default: false, null: false
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end

    create index(:todos, [:list_id])
  end
end
