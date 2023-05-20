defmodule TodoFamily.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lists" do
    field :name, :string
    field :uuid, Ecto.UUID, read_after_writes: true

    has_many :todos, TodoFamily.Todos.Todo

    timestamps()
  end

  @doc false
  def changeset(lists, attrs) do
    lists
    |> cast(attrs, [:uuid, :name])
    |> cast_assoc(:todos)
    |> validate_required([:name])
  end
end
