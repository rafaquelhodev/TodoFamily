defmodule TodoFamily.Todos.Todo do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "todos" do
    field :description, :string
    field :done, :boolean, default: false
    field :list_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(todo, attrs) do
    todo
    |> cast(attrs, [:description, :done, :list_id])
    |> validate_required([:description, :done])
  end
end
