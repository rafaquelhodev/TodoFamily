defmodule TodoFamilyWeb.Todos.TodosLive do
  use TodoFamilyWeb, :live_view

  alias TodoFamily.Lists
  alias TodoFamily.Todos

  @impl true
  def mount(params, _session, socket) do
    list_id = Map.get(params, "id")

    list = load_list(list_id)

    todos = Map.get(list, :todos, [])

    parsed_todos = parse_todos(todos)

    {:ok,
     assign(socket,
       todos: parsed_todos,
       list_id: list_id,
       changeset: build_changeset(),
       active_tab: :todos
     )}
  end

  def handle_event(
        "save",
        %{"user" => %{"description" => description}},
        socket = %{assigns: assigns = %{todos: todos}}
      ) do
    if is_nil(socket.assigns.list_id) do
      {:ok, list} = create_list(description)

      IO.inspect(list, label: "list")

      socket = assign(socket, list_id: list.id)

      {:noreply,
       push_redirect(socket,
         to: "/todos?id=#{list.id}",
         replace: true
       )}
    else
      {:ok, new_todo} = Todos.add_todo(%{description: description, list_id: assigns.list_id})

      todos = parse_todos([new_todo], todos)

      {:noreply,
       assign(socket,
         todos: todos
       )}
    end
  end

  @impl true
  def handle_event(
        "toggle_checkbox",
        %{"id" => id},
        socket = %{assigns: %{todos: todos}}
      ) do
    todos =
      Map.update(todos, id, nil, fn todo ->
        Map.put(todo, :done, !todo.done)
      end)

    {:noreply,
     assign(socket,
       todos: todos
     )}
  end

  defp load_list(nil), do: %{}

  defp load_list(list_id) do
    Lists.get_with_todos(list_id)
  end

  defp parse_todos(todos, todos_parsed \\ %{}) do
    Enum.reduce(todos, todos_parsed, fn todo, acc ->
      Map.put(acc, todo.id, Map.take(todo, [:done, :description]))
    end)
  end

  defp create_list(description) do
    Lists.create(%{
      name: "Todo list",
      todos: [
        %{description: description, done: false}
      ]
    })
  end

  defp build_changeset(params \\ %{}) do
    data = %{}

    types = %{
      description: :string
    }

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_required([:description])
    |> Ecto.Changeset.validate_length(:description, min: 3, max: 250)
  end
end
