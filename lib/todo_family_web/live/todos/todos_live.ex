defmodule TodoFamilyWeb.Todos.TodosLive do
  use TodoFamilyWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     assign(socket,
       todos: %{
         Ecto.UUID.generate() => %{text: "test", done: false},
         Ecto.UUID.generate() => %{text: "test 2", done: true}
       },
       active_tab: :todos
     )}
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

    IO.inspect(todos)

    {:noreply,
     assign(socket,
       todos: todos
     )}
  end
end
