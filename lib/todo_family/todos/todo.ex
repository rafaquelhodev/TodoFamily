defmodule TodoFamily.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  schema "todos" do
    field :description, :string
    field :done, :boolean, default: false
    field :uuid, Ecto.UUID
    field :list_id, :id

    timestamps()
  end

  @doc false
  def changeset(todos, attrs) do
    todos
    |> cast(attrs, [:uuid, :description, :done])
    |> validate_required([:description, :done])
  end
end
