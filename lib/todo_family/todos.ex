defmodule TodoFamily.Todos do
  alias TodoFamily.Repo
  alias TodoFamily.Todos.Todo

  def add_todo(attrs) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect()
  end
end
