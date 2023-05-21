defmodule TodoFamily.Todos do
  alias TodoFamily.Repo
  alias TodoFamily.Todos.Todo

  def add_todo(attrs) do
    %Todo{}
    |> Todo.changeset(attrs)
    |> Repo.insert()
    |> IO.inspect()
  end

  def update_done(todo, new_done) do
    todo
    |> Ecto.Changeset.change(%{done: new_done})
    |> Repo.update()
  end
end
