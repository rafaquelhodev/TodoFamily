defmodule TodoFamily.Lists.List do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "lists" do
    field :name, :string

    has_many :todos, TodoFamily.Todos.Todo

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name])
    |> cast_assoc(:todos)
    |> validate_required([:name])
  end
end
