defmodule TodoFamily.Lists do
  alias TodoFamily.Repo
  alias TodoFamily.Lists.List

  def get_with_todos(list_id) do
    Repo.get(List, list_id) |> Repo.preload(:todos)
  end

  def create(attrs) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end
end
