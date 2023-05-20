defmodule TodoFamily.Lists do
  alias TodoFamily.Repo
  alias TodoFamily.Lists.List

  def create(attrs) do
    %List{}
    |> List.changeset(attrs)
    |> Repo.insert()
  end
end
