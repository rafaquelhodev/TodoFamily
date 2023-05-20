# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     TodoFamily.Repo.insert!(%TodoFamily.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias TodoFamily.Lists

Lists.create(%{
  name: "Todo Example 1",
  todos: [
    %{description: "Buy groceries", done: false},
    %{description: "Do laundry", done: true},
    %{description: "Study history", done: false}
  ]
})
