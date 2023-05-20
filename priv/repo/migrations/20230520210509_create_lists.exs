defmodule TodoFamily.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    execute "CREATE EXTENSION IF NOT EXISTS pgcrypto"

    create table(:lists) do
      add :uuid, :uuid, null: false, default: fragment("gen_random_uuid()")
      add :name, :string

      timestamps()
    end

    create unique_index(:lists, [:uuid])
  end
end
