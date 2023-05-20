defmodule TodoFamilyWeb.Todos.TodosLive do
  use TodoFamilyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    changeset = build_changeset()

    {:ok,
     assign(socket,
       todos: %{
         Ecto.UUID.generate() => %{description: "test", done: false},
         Ecto.UUID.generate() => %{description: "test 2", done: true}
       },
       list_uuid: nil,
       changeset: changeset,
       active_tab: :todos
     )}
  end

  def handle_event(
        "save",
        %{"user" => %{"description" => description}},
        socket = %{assigns: %{todos: todos}}
      ) do
    todos = Map.put(todos, Ecto.UUID.generate(), %{description: description, done: false})

    if is_nil(socket.assigns.list_uuid) do
      uuid = Ecto.UUID.generate()
      socket = assign(socket, list_uuid: uuid)

      {:noreply,
       push_redirect(socket,
         to: "/todos?uuid=#{uuid}",
         replace: true
       )}
    else
      {:noreply,
       assign(socket,
         todos: todos
       )}
    end
  end

  @impl true
  def handle_event(
        "toggle_checkbox",
        %{"uuid" => uuid},
        socket = %{assigns: %{todos: todos}}
      ) do
    todos =
      Map.update(todos, uuid, nil, fn todo ->
        Map.put(todo, :done, !todo.done)
      end)

    {:noreply,
     assign(socket,
       todos: todos
     )}
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
