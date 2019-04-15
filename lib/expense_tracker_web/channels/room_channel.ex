defmodule ExpenseTrackerWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    broadcast!(socket, "new_msg", %{body: body})
    {:noreply, socket}
  end

  def handle_in("test", %{}, socket) do
    broadcast!(socket, "new_msg", %{body: "test!"})
    {:noreply, socket}
  end

  intercept ["new_msg"]

  def handle_out("new_msg", msg, socket) do
    IO.puts("handle out")
    IO.inspect(msg)
    _user_id = socket.assigns.user_id

    # push will forward the message to handle_in
    # push(socket, "new_msg", msg)

    {:noreply, socket}
  end
end
