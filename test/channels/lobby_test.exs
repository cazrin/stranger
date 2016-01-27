defmodule Stranger.Channel.LobbyTest do
  use Stranger.ChannelCase

  alias Stranger.{Lobby, Room}

  @id "my-test-id"
  @id2 "other-test-id"

  setup do
    {:ok, socket} = connect(Stranger.Socket, %{"id" => @id})
    {:ok, %{socket: socket}}
  end

  test "joining the lobby", %{socket: socket} do
    {:ok, _, socket} = join(socket, "lobby")
    assert Lobby.find(@id) == socket.channel_pid
  end

  test "leaving the lobby", %{socket: socket} do
    {:ok, _, socket} = join(socket, "lobby")
    Process.unlink(socket.channel_pid)
    channel_ref = Process.monitor(socket.channel_pid)

    ref = leave(socket)
    assert_reply ref, :ok

    assert_receive {:DOWN, ^channel_ref, :process, _, _}
    refute Lobby.find(@id)
  end

  test "another stranger joins the lobby", %{socket: socket} do
    {:ok, s_socket} = connect(Stranger.Socket, %{"id" => @id2})

    {:ok, _, socket} = join(socket, "lobby")
    {:ok, _, s_socket} = join(s_socket, "lobby")

    assert_push "join_room", %{name: name}
    assert_push "join_room", %{name: ^name}

    # Room was created with valid permissions for both IDs
    assert {:ok, _} = Room.join(name, @id, self)
    assert {:ok, _} = Room.join(name, @id2, self)

    Enum.each([socket, s_socket], fn(sock) ->
      Process.unlink(sock.channel_pid)
      close(sock)
    end)
  end
end
